import configparser
import locale
import subprocess
from datetime import datetime
import openpyxl
import pymysql
import win32com.client
from PyQt5.QtWidgets import (QApplication, QHeaderView, QLabel)
from PyQt5.uic import loadUiType
from PyQt5.QtGui import QColor, QStandardItemModel, QStandardItem, QFont
from PyQt5.QtCore import Qt
import sys
import os
import calendar

from openpyxl.reader.excel import load_workbook

Ui_MainWindow, QMainWindow = loadUiType("ZPui.ui")

class ExcelPrinter:
    def __init__(self, server_address, smb_share):
        # Получение адреса сервера из файла настроек
        config = configparser.ConfigParser()
        config.read('conf.ini')
        self.server_address = config.get('FileServ', 'server')
        self.server_address = server_address
        self.smb_share = '\\smb_share\\komendant\\'

    def print_excel_file(self):
        file_path = os.path.join(f'\\\\{self.server_address}\\{self.smb_share}', 'zptest.xlsx')

        workbook = load_workbook(file_path)
        worksheet = workbook.active or workbook['Sheet1']

        excel = win32com.client.Dispatch("Excel.Application")
        excel.Visible = False
        workbook = excel.Workbooks.Open(file_path)
        workbook.PrintOut()
        workbook.Close()
        excel.Quit()

class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        # Кнопка печати
        self.PBPrint.clicked.connect(self.transferRowsToTBTemp)

        # Кнопка добавить сотрудника
        self.PBAdd.clicked.connect(self.addNewRow)

        self.PBUncheck.clicked.connect(self.uncheckAllItems)

        # Получение адреса сервера из файла настроек
        config = configparser.ConfigParser()
        config.read('conf.ini')
        self.server_address = config.get('FileServ', 'server')
        self.smb_share = '\\smb_share\\komendant\\'

        # Получение настроек подключения к базе данных с удаленного сервера
        self.remote_file_path = f'\\\\{self.server_address}\\smb_share\\komendant\\conftest.ini'
        if os.path.exists(self.remote_file_path):
            remote_config = configparser.ConfigParser()
            remote_config.read(self.remote_file_path)
            self.server = remote_config.get('Connection', 'Server')
            self.user = remote_config.get('Connection', 'User')
            self.password = remote_config.get('Connection', 'Password')
            self.db = remote_config.get('Connection', 'BD')
            self.NachUch = remote_config.get('Uchastok','NachUch')
            self.uchastok = remote_config.get('Uchastok', 'Uchastok')
        else:
            print(f"Файл настроек {self.remote_file_path} не найден.")
            sys.exit()

        # Подключение к базе данных MariaDB
        connection = pymysql.connect(host=self.server,
                                     port=3306,
                                     user=self.user,
                                     password=self.password,
                                     db=self.db)

        # Получение данных из таблицы balki и obchaga
        self.cursor = connection.cursor()
        self.cursor.execute('SELECT * FROM balki')
        self.data_balki = self.cursor.fetchall()
        self.cursor.execute('SELECT * FROM obchaga')
        self.data_obchaga = self.cursor.fetchall()

        # Создание модели данных для таблицы
        self.model_all = QStandardItemModel()

        # Подключение сигнала изменения состояния чекбокса к обновлению количества
        self.model_all.itemChanged.connect(self.updateCheckedCount)

        for row_data in self.data_balki + self.data_obchaga:
            row = []
            self.check_item = QStandardItem()
            self.check_item.setCheckable(True)
            self.check_item.setEditable(False)
            row.append(self.check_item)
            for item in row_data:
                standard_item = QStandardItem(str(item))
                row.append(standard_item)
            percent_item = QStandardItem("100%")  # Создание элемента с содержимым "100%"
            row.append(percent_item)  # Добавление элемента в строку

            self.model_all.appendRow(row)

        # Заполняем таблицу данными
        self.TVGlav.setModel(self.model_all)

        # Удаляем лишнии столбцы
        self.model_all.removeColumn(8)
        self.model_all.removeColumn(7)
        self.model_all.removeColumn(5)
        self.model_all.removeColumn(4)
        self.model_all.removeColumn(2)
        self.model_all.removeColumn(1)

        self.model_all.setHorizontalHeaderLabels(
            ["Включить", "ФИО", "Должность", "Сумма"])  # Установка заголовков столбцов

        # Автоматическая подстройка ширины ячеек таблицы
        self.TVGlav.horizontalHeader().setSectionResizeMode(QHeaderView.ResizeToContents)

        # Добавление новой строки в конец таблицы
        new_row = [
            QStandardItem(self.check_item),
            QStandardItem(self.NachUch),
            QStandardItem("Начальник участка"),
            QStandardItem("П/О 50 т.р.")
        ]
        self.model_all.appendRow(new_row)

        # Закрытие соединения с базой данных
        self.cursor.close()
        connection.close()

        # Подключение сигнала изменения текста в поле ввода к методу поиска
        self.LESearch.textChanged.connect(self.searchTable)

        self.sortTableByFIO()

        # Создание модели данных для таблицы TBTemp
        self.model_TBTemp = QStandardItemModel()
        self.TBTemp.setModel(self.model_TBTemp)

        # Установка заголовков столбцов для TBTemp
        self.model_TBTemp.setHorizontalHeaderLabels(["ФИО", "Должность", "Сумма"])
        self.TBTemp.setVisible(False)
        locale.setlocale(locale.LC_ALL, 'ru_RU.utf8')

    def addNewRow(self):
        # Создание новой пустой строки
        new_row = [
            QStandardItem(self.check_item),
            QStandardItem(""),
            QStandardItem(""),
            QStandardItem("100%")
        ]
        self.model_all.appendRow(new_row)

    def uncheckAllItems(self):
        for row in range(self.model_all.rowCount()):
            item = self.model_all.item(row, 0)
            if item and item.isCheckable():
                item.setCheckState(Qt.Unchecked)

    def transferRowsToTBTemp(self):
        row_count = self.model_TBTemp.rowCount()  # Получаем текущее количество строк в model_TBTemp

        for row_index in range(self.model_all.rowCount()):
            check_item = self.model_all.item(row_index, 0)
            if check_item.checkState() == Qt.Checked:
                fio_item = self.model_all.item(row_index, 1)
                position_item = self.model_all.item(row_index, 2)
                sum_item = self.model_all.item(row_index, 3)

                # Проверяем, содержат ли элементы данные
                if fio_item.text() and position_item.text() and sum_item.text():
                    # Создаем новую строку из QStandardItem
                    row_data = [
                        QStandardItem(str(row_count + 1)),
                        QStandardItem(fio_item.text()),
                        QStandardItem(position_item.text()),
                        QStandardItem(sum_item.text()
                        )
                    ]
                    self.model_TBTemp.appendRow(row_data)
                    row_count += 1  # Увеличиваем счетчик строк в model_TBTemp
                else:
                    print(f"Одна из ячеек в строке {row_index} пуста. Строка не добавлена.")

        self.print_and_save_excel()

    # Сортировка таблицы по второму столбцу (ФИО)
    def sortTableByFIO(self):
        self.model_all.sort(1, Qt.AscendingOrder)

    # Поиск по таблице
    def searchTable(self, searchText):
        # Получение текущего индекса выбранной строки
        currentIndex = self.TVGlav.currentIndex()

        # Получение количества строк в модели
        rowCount = self.TVGlav.model().rowCount()

        # Проверка наличия элементов в модели
        if rowCount > 0:
            # Сброс выделения всех строк перед поиском
            for row in range(rowCount):
                self.TVGlav.model().setData(self.TVGlav.model().index(row, 1), QColor("white"), Qt.BackgroundRole)

            # Проход по всем строкам и поиск совпадений
            for row in range(rowCount):
                # Получение ячеек текущей строки
                item = self.TVGlav.model().item(row, 1)
                if item is not None:
                    # Проверка наличия совпадений в ячейке
                    if searchText.lower() in item.text().lower():
                        # Подсветка строки при нахождении совпадения
                        self.TVGlav.model().setData(self.TVGlav.model().index(row, 1), QColor("yellow"),
                                                    Qt.BackgroundRole)

            # Выделение первой найденной строки
            if rowCount > 0:
                for row in range(rowCount):
                    if self.TVGlav.model().item(row, 1).text().lower().find(searchText.lower()) != -1:
                        self.TVGlav.setCurrentIndex(self.TVGlav.model().index(row, 1))
                        break

            # Восстановление выбранной строки после поиска
            if currentIndex.isValid():
                self.TVGlav.setCurrentIndex(currentIndex)
        else:
            print("Модель данных пуста.")

        # Проверка наличия текста в поле ввода
        if searchText == "":
            # Сброс выделения всех строк после очистки поля ввода
            for row in range(rowCount):
                self.TVGlav.model().setData(self.TVGlav.model().index(row, 1), QColor("white"),
                                            Qt.BackgroundRole)

    def updateCheckedCount(self, item):
        if item.column() == 0:  # Проверяем изменение только в первой колонке (check_item)
            checked_count = 0
            for row in range(self.model_all.rowCount()):
                item = self.model_all.item(row, 0)  # Проверяем первую ячейку (check_item)
                if item is not None and item.checkState() == Qt.Checked:
                    checked_count += 1

            self.LCount.setText(" {}".format(checked_count))

            if checked_count >= 43:
                self.LCount.setFont(QFont("Arial", 16, QFont.Bold | QFont.StyleItalic))
                self.LCount.setStyleSheet("color: red;")
                self.PBPrint.setEnabled(False)
            else:
                self.LCount.setFont(QFont("Arial", 12, QFont.Bold | QFont.StyleItalic))
                self.LCount.setStyleSheet("color: black;")
                self.PBPrint.setEnabled(True)

    def print_and_save_excel(self):
        # Открытие файла с изменением атрибутов для доступа
        file_path = os.path.join(f'\\\\{self.server_address}\\smb_share\\komendant\\zptest.xlsx')
        workbook = openpyxl.load_workbook(file_path)
        sheet = workbook.active
        # Очистка таблицы
        for row in sheet.iter_rows(min_row=5, max_row=46, min_col=1, max_col=sheet.max_column):
            for cell in row:
                for merged_range in sheet.merged_cells.ranges:
                    if cell.coordinate in merged_range:
                        sheet.unmerge_cells(merged_range.coord)
                        break
                if cell.value is not None or cell.has_style:
                    cell.value = None
        # Получение предыдущего месяца и года если это январь
        current_year = datetime.now().strftime("%Y")
        prev_month = calendar.month_name[datetime.now().month - 1] if datetime.now().month != 1 else calendar.month_name[12]
        prev_year = current_year if datetime.now().month == 1 else current_year
        # Формирование статичных данных
        sheet['A1'] = f"Список работников на з\плату за {prev_month} {prev_year} г."
        sheet['C3'] = self.uchastok
        sheet['C48'] = self.NachUch

        # Запись данных из model_TBTemp в Excel, начиная с 5-й строки
        for row_index in range(5, self.model_TBTemp.rowCount() + 5):
            for column_index in range(1, self.model_TBTemp.columnCount() + 1):
                item = self.model_TBTemp.item(row_index - 5, column_index - 1)
                if item:
                    sheet.cell(row=row_index, column=column_index, value=item.text())

        # Сохранение файла
        workbook.save(file_path)
        # Печать файла
        printer = ExcelPrinter(self.server_address, self.smb_share)
        printer.print_excel_file()
        # Очистка данных в модели TBTemp
        self.model_TBTemp.clear()
    def closeEvent(self, event):

        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())