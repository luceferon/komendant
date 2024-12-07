import configparser
import sys
import pymysql
from PyQt5.QtWidgets import QApplication, QMessageBox
from PyQt5.uic import loadUiType
from settings import load_settings

Ui_MainWindow, QMainWindow = loadUiType("Relocateui.ui")


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self):
        super().__init__()
        self.mesto = None
        self.selected_row_house = None
        self.current_table_kuda = None
        self.selected_row_data = None
        self.current_table_otkuda = None
        self.setupUi(self)

        self.CBOtkuda.addItems(["", "Балки", "Общага"])
        self.CBKuda.addItems(["", "Балки", "Общага"])
        self.CBKuda.setEnabled(False)
        self.CBKuda_House.setEnabled(False)
        self.PBOk.setEnabled(False)

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

        self.CBOtkuda.currentIndexChanged.connect(self.CBOtkuda_changed)
        self.PBCancel.clicked.connect(self.start_main)
        self.CBKogo.currentIndexChanged.connect(self.CBKogo_changed)
        self.CBKuda.currentIndexChanged.connect(self.CBKuda_changed)
        self.CBKuda_House.currentIndexChanged.connect(self.CBKuda_House_changed)
        self.PBOk.clicked.connect(self.PBOk_clicked)

    def CBOtkuda_changed(self, index):
        self.current_table_otkuda = "balki" if self.CBOtkuda.currentText() == "Балки" else "obchaga"
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
        items = [result[0] for result in results]
        items.sort()
        self.CBKogo.addItems(items)

    def CBKogo_changed(self):
        self.CBKuda.setEnabled(True)
        self.CBKuda_House.setEnabled(True)
        selected_name = self.CBKogo.currentText()
        selected_table = "balki" if self.CBOtkuda.currentText() == "Балки" else "obchaga"
        query = (f"SELECT `ФИО_сотрудника`, `Комментарий`, `Дата_заезда_отпуска`, `Должность`, `Организация`, "
                 f"`Контактный_телефон` FROM {selected_table} WHERE `ФИО_сотрудника` = '{selected_name}'")
        cur = self.connection.cursor()
        cur.execute(query)
        self.selected_row_data = cur.fetchone()
        if self.selected_row_data:
            fio_sotrudnika, kommentarii, data_zaezda_otpuska, dolzhnost, organizatsiya, kontakt = self.selected_row_data

    def CBKuda_changed(self, index):
        self.current_table_kuda = "balki" if self.CBKuda.currentText() == "Балки" else "obchaga"
        if self.CBKuda.currentText() == "Балки":
            self.CBKuda_House_add("balki")
        elif self.CBKuda.currentText() == "Общага":
            self.CBKuda_House_add("obchaga")
        self.CBKuda_House_changed()

    def CBKuda_House_add(self, table_name):
        query = f"SELECT DISTINCT `Номер` FROM {table_name}"
        cur = self.connection.cursor()
        cur.execute(query)
        results = cur.fetchall()
        self.CBKuda_House.clear()
        self.CBKuda_House.addItems([result[0] for result in results])

    def CBKuda_House_changed(self):
        selected_name = self.CBKuda_House.currentText()
        selected_table = "balki" if self.CBOtkuda.currentText() == "Балки" else "obchaga"
        query = f"SELECT `Кол_во_мест` FROM {selected_table} WHERE `Номер` = '{selected_name}'"
        cur = self.connection.cursor()
        cur.execute(query)
        self.selected_row_house = cur.fetchone()
        if self.selected_row_house:
            self.mesto = self.selected_row_house[0]
        self.PBOk.setEnabled(True)

    def PBOk_clicked(self):
        selected_name = self.CBKogo.currentText()
        selected_table = "balki" if self.CBOtkuda.currentText() == "Балки" else "obchaga"
        delete_query = f"DELETE FROM {self.current_table_otkuda} WHERE `ФИО_сотрудника` = '{selected_name}'"
        cur_delete = self.connection.cursor()
        cur_delete.execute(delete_query)
        self.connection.commit()
        insert_query = (f"INSERT INTO {self.current_table_kuda} (`Номер`, `Кол_во_мест`, `ФИО_сотрудника`, "
                        f"`Комментарий`, `Дата_заезда_отпуска`, `Должность`, `Организация`, `Контактный_тел"
                        f"ефон`) VALUES ('{self.CBKuda_House.currentText()}', {self.mesto}, '"
                        f"{self.selected_row_data[0]}', '{self.selected_row_data[1]}', '{self.selected_row_data[2]}', "
                        f"'{self.selected_row_data[3]}', '{self.selected_row_data[4]}', '{self.selected_row_data[5]}')")
        cur_insert = self.connection.cursor()
        cur_insert.execute(insert_query)
        self.connection.commit()
        self.close()

    def start_main(self):
        self.close()

    def closeEvent(self, event):
        self.close()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())
