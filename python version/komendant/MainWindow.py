import configparser
import sys
import subprocess
from PyQt5.QtWidgets import QApplication
from PyQt5.uic import loadUiType

Ui_MainWindow, QMainWindow = loadUiType("MainWindowui.ui")


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.BExit.clicked.connect(self.close)
        self.BSpisok.clicked.connect(self.start_zaselenie)
        self.BZaselenie.clicked.connect(self.start_add)
        self.BViselit.clicked.connect(self.start_del)
        self.BPereselit.clicked.connect(self.start_relocate)
        config = configparser.ConfigParser()
        config.read('conf_prog.ini')
        self.server_address = config.get('FileServ', 'server')
        self.smb_share = '\\smb_share\\komendant\\'
        self.file_path = f'\\\\{self.server_address}{self.smb_share}'

    def start_zaselenie(self):
        subprocess.Popen(["python", f"{self.file_path}Zaselenie.py"])
        self.close()

    def start_add(self):
        subprocess.Popen(["python", f"{self.file_path}Add.py"])
        self.close()

    def start_del(self):
        subprocess.Popen(["python", f"{self.file_path}Del.py"])
        self.close()

    def start_relocate(self):
        subprocess.Popen(["python", f"{self.file_path}Relocate.py"])
        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
