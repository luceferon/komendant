import sys
import subprocess
from PyQt5.QtWidgets import QApplication, QMainWindow
from PyQt5.uic import loadUiType

# Загрузка интерфейса из файла MainWindow.ui
Ui_MainWindow, QMainWindow = loadUiType("./MainWindowui.ui")


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        # Подключение слота для кнопки BExit
        self.BExit.clicked.connect(self.close)

        # Подключение слота для кнопки BSpisok
        self.BSpisok.clicked.connect(self.start_zaselenie)

    def start_zaselenie(self):
        # Запуск Zaselenie.py
        subprocess.Popen(["python", "Zaselenie.py"])

        # Закрытие текущего окна MainWindow
        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
