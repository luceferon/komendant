import configparser
import sys
import pymysql
from PyQt5.QtCore import QDate, QRegExp
from PyQt5.QtGui import QRegExpValidator, QFont
from PyQt5.QtWidgets import QApplication, QMessageBox
from PyQt5.uic import loadUiType
from settings import load_settings

Ui_MainWindow, QMainWindow = loadUiType("Addui.ui")


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        # Указываем первичные значения компонентов
        self.CBKuda.addItems(["Балки", "Общага"])
        self.DEDateZaezda.setDate(QDate.currentDate())
        self.CBCompany.addItems(["ООО \"А-Сервис\"", "ООО \"Еда\"", "ООО \"Буфет\"", "ООО \"КомплектСервис\"",
                                 "ООО \"МоторСервис\"", "ООО \"Сисим\"", "ООО \"ГМК Ангара\"", "ООО \"СпецПодряд\"", "ООО \"КрасИнтегра\"", "ЧОО \"Ангара\""])
        self.CBDolznost.addItems(["Машинист бульдозера", "Машинист экскаватора", "Горный мастер",
                                  "Слесарь-ремонтник", "Вальщик", "Водитель", "Гидромониторщик",
                                  "Кух. Рабочий", "Водитель погрузчика", "Сварщик", "Гость",
                                  "Повар", "Водитель АТЗ", "Моторист", "Токарь", "Кладовщик ГСМ",
                                  "Кладовщик ТМЦ", "Геолог", "Маркшейдер", "Старший повар", "Водитель крана", "Контроллер", "Охранник"])
        self.LETelefone.setPlaceholderText("В формате 8(***)***-**-**")
        self.LETelefone.setValidator(
            QRegExpValidator(QRegExp(r'^(\d{1})[\s-]?(\d{3})[\s-]?(\d{3})[\s-]?(\d{2})[\s-]?(\d{2})$')))
        self.LETelefone.textChanged.connect(self.validate_phone)
        self.CBHouse.setEnabled(False)
        self.LEFIO.setEnabled(False)
        self.DEDateZaezda.setEnabled(False)
        self.CBDolznost.setEnabled(False)
        self.LEKomment.setEnabled(False)
        self.CBCompany.setEnabled(False)
        self.LETelefone.setEnabled(False)
        self.PBOK.setEnabled(False)

        # Указываем подключение к БД
        config = configparser.ConfigParser()
        config.read('conf.ini')
        self.server_address = config.get('FileServ', 'server')
        config_file_path = f'\\\\{self.server_address}\\smb_share\\komendant\\conf.ini'
        settings = load_settings(config_file_path)

        if settings is not None:
            self.server, self.user, self.password, self.db, self.NachUch, self.Uchastok, self.Kladovchik, self.SysAdmin = settings
            self.connection = pymysql.connect(host=self.server, port=3306, user=self.user, password=self.password,
                                         db=self.db)
        else:
            QMessageBox.warning(self, "Warning", f"Файл настроек {config_file_path} не найден.", QMessageBox.Ok)
            sys.exit()

        self.CBKuda.currentIndexChanged.connect(self.on_CBKuda_changed)
        self.PBCancel.clicked.connect(self.cancel_pressed)
        self.CBHouse.currentIndexChanged.connect(self.on_CBHouse_changed)
        self.LEFIO.textChanged.connect(self.on_LEFIO_changed)
        self.CBDolznost.currentIndexChanged.connect(self.on_CBDolznost_changed)
        self.CBCompany.currentIndexChanged.connect(self.on_CBCompany_changed)
        self.PBOK.clicked.connect(self.save_to_db)

    def on_CBKuda_changed(self, index):
        if self.CBKuda.currentText() == "Балки":
            self.fill_CBHouse_with_table_values("balki")
        elif self.CBKuda.currentText() == "Общага":
            self.fill_CBHouse_with_table_values("obchaga")
        self.CBHouse.setEnabled(True)

    def fill_CBHouse_with_table_values(self, table_name):
        query = f"SELECT DISTINCT `Номер` FROM {table_name}"
        cur = self.connection.cursor()
        cur.execute(query)
        results = cur.fetchall()
        self.CBHouse.clear()
        self.CBHouse.addItems([result[0] for result in results])

    def on_CBHouse_changed(self):
        self.LEFIO.setEnabled(True)
        selected_house = self.CBHouse.currentText()
        if not selected_house:
            return
        table_name = "balki" if self.CBKuda.currentText() == "Балки" else "obchaga"
        query = f"SELECT DISTINCT `Кол_во_мест`, `ФИО_сотрудника` FROM {table_name} WHERE `Номер` = '{selected_house}'"
        cur = self.connection.cursor()
        cur.execute(query)
        results = cur.fetchall()
        unique_values = set(result[0] for result in results)
        fio_values = set(result[1] for result in results)
        self.LMest.setText('\n'.join(unique_values))
        self.PTEStatus.clear()
        self.PTEStatus.setPlainText('\n'.join(fio_values))
        num_lmest = int(self.LMest.text()) if self.LMest.text().isdigit() else 0
        if len(fio_values) > num_lmest:
            self.LMest.setStyleSheet("color: red;")
            font = QFont()
            font.setPointSize(14)
            self.LMest.setFont(font)
        else:
            self.LMest.setStyleSheet("")
            font = QFont()
            font.setPointSize(8)
            self.LMest.setFont(font)

    def on_LEFIO_changed(self):
        self.DEDateZaezda.setEnabled(True)
        self.CBDolznost.setEnabled(True)

    def on_CBDolznost_changed(self):
        self.LEKomment.setEnabled(True)
        self.CBCompany.setEnabled(True)
        self.LETelefone.setEnabled(True)

    def on_CBCompany_changed(self):
        self.PBOK.setEnabled(True)

    def validate_phone(self):
        text = self.LETelefone.text()
        phone_digits = ''.join(filter(str.isdigit, text))
        if len(phone_digits) == 11:
            formatted_phone = '8({}){}-{}-{}'.format(phone_digits[1:4], phone_digits[4:7], phone_digits[7:9],
                                                     phone_digits[9:11])
            self.LETelefone.setText(formatted_phone)

    def save_to_db(self):
        table_name = "balki" if self.CBKuda.currentText() == "Балки" else "obchaga"
        formatted_date = self.DEDateZaezda.date().toString("dd.MM.yyyy")
        if self.PTEStatus.toPlainText().count('\n') >= int(self.LMest.text()):
            confirmation = QMessageBox.question(self, 'Предупреждение',
                                                'В данном помещении уже проживает максимальное количество людей. Вы '
                                                'точно хотите добавить еще?',
                                                QMessageBox.Ok | QMessageBox.Cancel)
            if confirmation == QMessageBox.Ok:
                query = f"""INSERT INTO {table_name} 
                               (`Номер`, `Кол_во_мест`, `ФИО_сотрудника`, `Комментарий`, 
                                `Дата_заезда_отпуска`, `Должность`, `Организация`, `Контактный_телефон`)
                               VALUES 
                               ('{self.CBHouse.currentText()}', '{self.LMest.text()}',
                                '{self.LEFIO.text()}', '{self.LEKomment.text()}',
                                '{formatted_date}',
                                '{self.CBDolznost.currentText()}', '{self.CBCompany.currentText()}',
                                '{self.LETelefone.text()}')"""
                cur = self.connection.cursor()
                cur.execute(query)
                self.connection.commit()
                self.close()
        else:
            query = f"""INSERT INTO {table_name} 
                                           (`Номер`, `Кол_во_мест`, `ФИО_сотрудника`, `Комментарий`, 
                                            `Дата_заезда_отпуска`, `Должность`, `Организация`, `Контактный_телефон`)
                                           VALUES 
                                           ('{self.CBHouse.currentText()}', '{self.LMest.text()}',
                                            '{self.LEFIO.text()}', '{self.LEKomment.text()}',
                                            '{formatted_date}',
                                            '{self.CBDolznost.currentText()}', '{self.CBCompany.currentText()}',
                                            '{self.LETelefone.text()}')"""
            cur = self.connection.cursor()
            cur.execute(query)
            self.connection.commit()
            self.close()

    def cancel_pressed(self):
        self.close()

    def closeEvent(self, event):
        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())