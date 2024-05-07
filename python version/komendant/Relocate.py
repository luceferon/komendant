import sys
import subprocess
from PyQt5.QtWidgets import QApplication
from PyQt5.uic import loadUiType

Ui_MainWindow, QMainWindow = loadUiType("Relocateui.ui")


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
