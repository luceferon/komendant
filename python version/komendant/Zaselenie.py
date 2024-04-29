import configparser
import subprocess
import pymysql
from PyQt5.QtWidgets import (QApplication, QHeaderView)
from PyQt5.uic import loadUiType
from PyQt5.QtGui import QStandardItemModel, QStandardItem, QColor
from PyQt5.QtCore import Qt
import sys
import os

Ui_MainWindow, QMainWindow = loadUiType("Zaselenie.ui")


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
        cursor = connection.cursor()
        cursor.execute('SELECT * FROM balki')
        data = cursor.fetchall()
        cursor.execute('SELECT * FROM obchaga')
        data_obchaga = cursor.fetchall()

        # Создание модели данных для таблицы
        model = QStandardItemModel()
        model_obchaga = QStandardItemModel()

        # Добавление заголовков столбцов и запрет редактирования
        headers = ['Номер', 'Кол-во_мест', 'ФИО_сотрудника', 'Комментарий', 'Дата_заезда_отпуска', 'Должность',
                   'Организация', 'Контактный_телефон', ]
        for header in headers:
            item = QStandardItem(header)
            item.setEditable(False)  # Запрет редактирования ячеек
            model.setHorizontalHeaderItem(headers.index(header), item)

        headers_obchaga = ['Номер', 'Кол-во_мест', 'ФИО_сотрудника', 'Комментарий', 'Дата_заезда_отпуска', 'Должность',
                           'Организация', 'Контактный_телефон', ]
        for header in headers_obchaga:
            item = QStandardItem(header)
            item.setEditable(False)  # Запрет редактирования ячеек
            model_obchaga.setHorizontalHeaderItem(headers_obchaga.index(header), item)

        # Добавление данных в модель и запрет редактирования ячеек
        for row_data in data:
            row = []
            for column_data in row_data:
                item = QStandardItem(str(column_data))
                item.setEditable(False)  # Запрет редактирования ячеек
                row.append(item)
            model.appendRow(row)

        for row_data in data_obchaga:
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

        # Закрытие соединения с базой данных
        cursor.close()
        connection.close()

        # Подключение сигнала изменения текста в поле ввода к методу поиска
        self.LESearch.textChanged.connect(self.searchTable)

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
