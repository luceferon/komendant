import configparser
import os
import sys
import subprocess
import pymysql
from PyQt5.QtWidgets import QApplication
from PyQt5.uic import loadUiType

Ui_MainWindow, QMainWindow = loadUiType("Delui.ui")

class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        self.CBOtkuda.addItems(["Балки", "Общага"])

        # Указываем подключение к БД
        config = configparser.ConfigParser()
        config.read('conf.ini')
        self.server_address = config.get('FileServ', 'server')
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
        self.connection = pymysql.connect(host=self.server,
                                          port=3306,
                                          user=self.user,
                                          password=self.password,
                                          db=self.db)

        self.CBOtkuda.currentIndexChanged.connect(self.CBOtkuda_changed)

        self.PBCancel.clicked.connect(self.start_main)

        self.PBOK.clicked.connect(self.delete_row)

    def delete_row(self):
        selected_name = self.CBKogo.currentText()
        selected_table = "balki" if self.CBOtkuda.currentText() == "Балки" else "obchaga"
        query = f"DELETE FROM {selected_table} WHERE `ФИО_сотрудника` = '{selected_name}'"

        cur = self.connection.cursor()
        cur.execute(query)
        self.connection.commit()
        self.close()

    def CBOtkuda_changed(self, index):
        if self.CBOtkuda.currentText() == "Балки":
            self.CBKogo_add("balki")
        elif self.CBOtkuda.currentText() == "Общага":
            self.CBKogo_add("obchaga")

    def CBKogo_add(self, table_name):
        query = f"SELECT DISTINCT `ФИО_сотрудника` FROM {table_name}"
        cur = self.connection.cursor()
        cur.execute(query)
        results = cur.fetchall()
        self.CBKogo.clear()
        self.CBKogo.addItems([result[0] for result in results])

    def start_main(self):

        self.close()

    def closeEvent(self, event):

        subprocess.Popen(["python", "mainwindow.py"])

        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
