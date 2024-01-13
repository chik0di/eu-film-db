import mysql.connector
import configparser

config_parser = configparser.ConfigParser()
config_parser.read('config.ini')

def get_connection():
    config = {
    'host': config_parser.get('database', 'host'),
    'user': config_parser.get('database', 'user'),
    'password': config_parser.get('database', 'password'),
    'database': config_parser.get('database', 'schema'),
}
    try:
        print("Before connection attempt")
        connection = mysql.connector.connect(**config)
        print("Connection successful")
        return connection

    except Exception as e:
        print(f"Error connecting to the database: {e}")
        return None

# Call the function
get_connection()
