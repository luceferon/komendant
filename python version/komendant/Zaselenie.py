import configparser
import subprocess
import pymysql
import xlsxwriter
from xlsxwriter.format import Format
from PyQt5.QtWidgets import (QApplication, QHeaderView, QCheckBox, QDialog, QVBoxLayout, QDialogButtonBox,
                             QMessageBox)
from PyQt5.uic import loadUiType
from PyQt5.QtGui import QStandardItemModel, QStandardItem, QColor
from PyQt5.QtCore import Qt
import sys
import os

Ui_MainWindow, QMainWindow = loadUiType("Zaselenie.ui")

class ExportDialog(QDialog):
    def __init__(self, columns):
        super().__init__()
        self.setWindowTitle("Выберите столбцы для экспорта")

        self.layout = QVBoxLayout()

        for i, column in enumerate(columns):
            checkbox = QCheckBox(column)
            self.layout.addWidget(checkbox)
            setattr(self, f"cb_{i}", checkbox)

        self.buttonBox = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel)
        self.buttonBox.accepted.connect(self.accept)
        self.buttonBox.rejected.connect(self.reject)

        self.layout.addWidget(self.buttonBox)

        self.setLayout(self.layout)

class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        # Подключение слота для кнопки BExit
        self.PBclose.clicked.connect(self.close)

        # Получение адреса сервера из файла настроек
        config = configparser.ConfigParser()
        config.read('conf.ini')
        server_address = config.get('FileServ', 'server')

        # Получение настроек подключения к базе данных с удаленного сервера
        remote_file_path = f'\\\\{server_address}\\smb_share\\komendant\\conftest.ini'
        if os.path.exists(remote_file_path):
            remote_config = configparser.ConfigParser()
            remote_config.read(remote_file_path)
            server = remote_config.get('Connection', 'Server')
            user = remote_config.get('Connection', 'User')
            password = remote_config.get('Connection', 'Password')
            db = remote_config.get('Connection', 'BD')
        else:
            print(f"Файл настроек {remote_file_path} не найден.")
            sys.exit()

        # Подключение к базе данных MariaDB
        connection = pymysql.connect(host=server,
                                     port=3306,
                                     user=user,
                                     password=password,
                                     db=db)

        # Получение данных из таблицы balki
        self.cursor = connection.cursor()
        self.cursor.execute('SELECT * FROM balki')
        self.data = self.cursor.fetchall()
        self.cursor.execute('SELECT * FROM obchaga')
        self.data_obchaga = self.cursor.fetchall()

        # Создание модели данных для таблицы
        model = QStandardItemModel()
        model_obchaga = QStandardItemModel()

        # Добавление заголовков столбцов и запрет редактирования
        self.headers = ['Номер', 'Кол-во_мест', 'ФИО_сотрудника', 'Комментарий', 'Дата_заезда_отпуска', 'Должность',
                   'Организация', 'Контактный_телефон', ]
        for header in self.headers:
            item = QStandardItem(header)
            item.setEditable(False)  # Запрет редактирования ячеек
            model.setHorizontalHeaderItem(self.headers.index(header), item)

        self.headers_obchaga = ['Номер', 'Кол-во_мест', 'ФИО_сотрудника', 'Комментарий', 'Дата_заезда_отпуска', 'Должность',
                           'Организация', 'Контактный_телефон', ]
        for header in self.headers_obchaga:
            item = QStandardItem(header)
            item.setEditable(False)  # Запрет редактирования ячеек
            model_obchaga.setHorizontalHeaderItem(self.headers_obchaga.index(header), item)

        # Добавление данных в модель и запрет редактирования ячеек
        for row_data in self.data:
            row = []
            for column_data in row_data:
                item = QStandardItem(str(column_data))
                item.setEditable(False)  # Запрет редактирования ячеек
                row.append(item)
            model.appendRow(row)

        for row_data in self.data_obchaga:
            row = []
            for column_data in row_data:
                item = QStandardItem(str(column_data))
                item.setEditable(False)  # Запрет редактирования ячеек
                row.append(item)
            model_obchaga.appendRow(row)

        # Установка модели данных для таблицы
        self.TVBalki.setModel(model)
        self.TVObchaga.setModel(model_obchaga)

        # Автоматическая подстройка ширины ячеек таблицы
        self.TVBalki.horizontalHeader().setSectionResizeMode(QHeaderView.ResizeToContents)
        self.TVObchaga.horizontalHeader().setSectionResizeMode(QHeaderView.ResizeToContents)

        # Подключение слота для кнопки PBExport
        self.PBExport.clicked.connect(self.export_data)

        # Закрытие соединения с базой данных
        self.cursor.close()
        connection.close()

        # Подключение сигнала изменения текста в поле ввода к методу поиска
        self.LESearch.textChanged.connect(self.searchTable)

    def export_data(self):
        columns = ['Номер', 'ФИО_сотрудника', 'Комментарий', 'Дата_заезда_отпуска', 'Должность',
                           'Организация', 'Контактный_телефон', ]
        # Создание диалогового окна для выбора столбцов
        export_dialog = ExportDialog(columns)
        result = export_dialog.exec_()

        if result == QDialog.Accepted:
            selected_columns = []
            for i, column in enumerate(columns):
                if getattr(export_dialog, f"cb_{i}").isChecked():
                    selected_columns.append(column)

            # Создание файла Excel и экспорт данных
            workbook = xlsxwriter.Workbook('C:\Комендант\Списки сотрудников.xlsx')
            worksheet = workbook.add_worksheet()

            bold = workbook.add_format({'bold': True})
            header_format = workbook.add_format(
                {'font_name': 'Arial', 'font_size': 12, 'text_wrap': False, 'align': 'center'})

            # Запись заголовков столбцов
            for col, column in enumerate(selected_columns, start=1):
                worksheet.write(0, col, column, header_format)

            # Запись данных из таблицы balki
            row = 1
            for data_row in self.data:
                col = 1
                for column in selected_columns:
                    col_index = self.headers.index(column)
                    data = data_row[col_index]

                    # Format cells based on content
                    if isinstance(data, str) and len(data) > 50:
                        worksheet.set_column(col, col, 30)
                    elif isinstance(data, int) or isinstance(data, float):
                        worksheet.set_column(col, col, 10)

                    worksheet.write(row, col, data_row[col_index])
                    col += 1
                row += 1

            # Запись данных из таблицы obchaga
            for data_row in self.data_obchaga:
                col = 1
                for column in selected_columns:
                    col_index = self.headers_obchaga.index(column)

                    data = data_row[col_index]

                    # Format cells based on content
                    if isinstance(data, str) and len(data) > 50:
                        worksheet.set_column(col, col, 30)
                    elif isinstance(data, int) or isinstance(data, float):
                        worksheet.set_column(col, col, 10)

                    worksheet.write(row, col, data_row[col_index])
                    col += 1
                row += 1

            workbook.close()

            # Вывод сообщения об успешном экспорте
            QMessageBox.information(self, "Экспорт завершен", "Данные успешно экспортированы в файл 'C:\Комендант\Списки сотрудников.xlsx'.")

    def searchTable(self, searchText):
        # Получение текущего индекса выбранной строки
        currentIndex = self.TVBalki.currentIndex()

        # Получение количества строк в модели
        rowCount = self.TVBalki.model().rowCount()

        # Проверка наличия элементов в модели
        if rowCount > 0:
            # Сброс выделения всех строк перед поиском
            for row in range(rowCount):
                self.TVBalki.model().setData(self.TVBalki.model().index(row, 2), QColor("white"), Qt.BackgroundRole)

            # Проход по всем строкам и поиск совпадений
            for row in range(rowCount):
                # Получение ячеек текущей строки
                item = self.TVBalki.model().item(row, 2)
                if item is not None:
                    # Проверка наличия совпадений в ячейке
                    if searchText.lower() in item.text().lower():
                        # Подсветка строки при нахождении совпадения
                        self.TVBalki.model().setData(self.TVBalki.model().index(row, 2), QColor("yellow"),
                                                     Qt.BackgroundRole)

            # Выделение первой найденной строки
            if rowCount > 0:
                for row in range(rowCount):
                    if self.TVBalki.model().item(row, 2).text().lower().find(searchText.lower()) != -1:
                        self.TVBalki.setCurrentIndex(self.TVBalki.model().index(row, 0))
                        break

            rowCount_obchaga = self.TVObchaga.model().rowCount()
            if rowCount_obchaga > 0:
                # Сброс выделения всех строк перед поиском
                for row in range(rowCount_obchaga):
                    self.TVObchaga.model().setData(self.TVObchaga.model().index(row, 2), QColor("white"),
                                                   Qt.BackgroundRole)

                # Проход по всем строкам и поиск совпадений
                for row in range(rowCount_obchaga):
                    # Получение ячеек текущей строки
                    item = self.TVObchaga.model().item(row, 2)
                    if item is not None:
                        # Проверка наличия совпадений в ячейке
                        if searchText.lower() in item.text().lower():
                            # Подсветка строки при нахождении совпадения
                            self.TVObchaga.model().setData(self.TVObchaga.model().index(row, 2), QColor("yellow"),
                                                           Qt.BackgroundRole)

                # Выделение первой найденной строки
                if rowCount_obchaga > 0:
                    for row in range(rowCount_obchaga):
                        if self.TVObchaga.model().item(row, 2).text().lower().find(searchText.lower()) != -1:
                            self.TVObchaga.setCurrentIndex(self.TVObchaga.model().index(row, 0))
                            break

            # Восстановление выбранной строки после поиска
            if currentIndex.isValid():
                self.TVBalki.setCurrentIndex(currentIndex)
        else:
            print("Модель данных пуста.")

        # Проверка наличия текста в поле ввода
        if searchText == "":
            # Сброс выделения всех строк после очистки поля ввода
            for row in range(rowCount):
                self.TVBalki.model().setData(self.TVBalki.model().index(row, 2), QColor("white"),
                                             Qt.BackgroundRole)

    def closeEvent(self, event):
        # Запуск Zaselenie.py
        subprocess.Popen(["python", "mainwindow.py"])

        # Закрытие текущего окна
        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
