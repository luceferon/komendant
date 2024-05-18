import os
import subprocess
import sys
import atexit
import configparser
from PyQt5.QtWidgets import QApplication, QMessageBox
from PyQt5.uic import loadUiType

Ui_MainWindow, QMainWindow = loadUiType("MainWindowui.ui")

lock_file = ""
conf_file = "conf.ini"


def read_server_address():
    config = configparser.ConfigParser()
    config.read(conf_file)
    server_address = config.get('FileServ', 'server')
    return server_address


def set_lock_file_path(server_address):
    global lock_file
    lock_file = fr"\\{server_address}\smb_share\komendant\lockfile.lock"


def create_lock():
    open(lock_file, 'w').close()


def remove_lock():
    if os.path.exists(lock_file):
        os.remove(lock_file)


def start_relocate():
    subprocess.Popen(["python", "Relocate.py"])


def start_del():
    subprocess.Popen(["python", "Del.py"])


def start_add():
    subprocess.Popen(["python", "Add.py"])


def start_zaselenie():
    subprocess.Popen(["python", "Zaselenie.py"])


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        if os.path.exists(lock_file):
            QMessageBox.warning(self, "Warning", f"Приложение уже запущено на другом компьютере!", QMessageBox.Ok)
            sys.exit(1)
        else:
            create_lock()
            self.setupUi(self)
            self.BExit.clicked.connect(self.close)
            self.BSpisok.clicked.connect(start_zaselenie)
            self.BZaselenie.clicked.connect(start_add)
            self.BViselit.clicked.connect(start_del)
            self.BPereselit.clicked.connect(start_relocate)


if __name__ == "__main__":
    server_address = read_server_address()
    set_lock_file_path(server_address)

    app = QApplication(sys.argv)
    window = MainWindow()
    if not os.path.exists(lock_file):
        sys.exit(1)  # Выходим из программы, если файл блокировки создан
    atexit.register(remove_lock)  # Регистрируем функцию для удаления файла блокировки при выходе из программы
    window.show()
    sys.exit(app.exec_())
