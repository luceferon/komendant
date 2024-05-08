import os
import configparser


def load_settings(config_file_path):
    if os.path.exists(config_file_path):
        config = configparser.ConfigParser()
        config.read(config_file_path)
        server = config.get('Connection', 'Server')
        user = config.get('Connection', 'User')
        password = config.get('Connection', 'Password')
        db = config.get('Connection', 'BD')
        NachUch = config.get('Uchastok', 'NachUch')
        Uchastok = config.get('Uchastok', 'Uchastok')
        Kladovchik = config.get('Uchastok', 'Kladovchik')
        SysAdmin = config.get('Uchastok', 'SysAdmin')

        return server, user, password, db, NachUch, Uchastok, Kladovchik, SysAdmin
    else:
        return None