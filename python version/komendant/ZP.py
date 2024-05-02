import configparser
import subprocess
import pymysql
from PyQt5.QtWidgets import (QApplication, QHeaderView)
from PyQt5.uic import loadUiType
from PyQt5.QtGui import QColor, QStandardItemModel, QStandardItem
from PyQt5.QtCore import Qt
import sys
import os

Ui_MainWindow, QMainWindow = loadUiType("ZPui.ui")

class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        # Получение адреса сервера из файла настроек
        config = configparser.ConfigParser()
        config.read('conf.ini')
        self.server_address = config.get('FileServ', 'server')

        # Получение настроек подключения к базе данных с удаленного сервера
        self.remote_file_path = f'\\\\{self.server_address}\\smb_share\\komendant\\conftest.ini'
        if os.path.exists(self.remote_file_path):
            remote_config = configparser.ConfigParser()
            remote_config.read(self.remote_file_path)
            self.server = remote_config.get('Connection', 'Server')
            self.user = remote_config.get('Connection', 'User')
            self.password = remote_config.get('Connection', 'Password')
            self.db = remote_config.get('Connection', 'BD')
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
        for row_data in self.data_balki + self.data_obchaga:
            row = []
            check_item = QStandardItem()
            check_item.setCheckable(True)
            check_item.setEditable(False)
            row.append(check_item)
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

        # Закрытие соединения с базой данных
        self.cursor.close()
        connection.close()

        # Подключение сигнала изменения текста в поле ввода к методу поиска
        self.LESearch.textChanged.connect(self.searchTable)

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

    def closeEvent(self, event):

        # Запуск Zaselenie.py
        #subprocess.Popen(["python", "Zaselenie.py"])

        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())