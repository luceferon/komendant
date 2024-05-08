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

    def start_zaselenie(self):
        subprocess.Popen(["python", "Zaselenie.py"])
        self.close()

    def start_add(self):
        subprocess.Popen(["python", "Add.py"])
        self.close()

    def start_del(self):
        subprocess.Popen(["python", "Del.py"])
        self.close()

    def start_relocate(self):
        subprocess.Popen(["python", "Relocate.py"])
        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
