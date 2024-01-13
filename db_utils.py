import mysql.connector
import configparser

config_parser = configparser.ConfigParser()
config_parser.read('config.ini')

def get_connection():
    config = {
    'host': config.get('database', 'host'),
    'user': config.get('database', 'user'),
    'password': config.get('database', 'password'),
    'database': config.get('database', 'database'),
}
    return mysql.connector.connect(**config)
