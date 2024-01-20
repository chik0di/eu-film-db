# app.py
import streamlit as st
import pymysql
import configparser
import pandas as pd

config_parser = configparser.ConfigParser()
config_parser.read('config.ini')

def get_connection():
    config = {
    'host': config_parser.get('database', 'host'),
    'user': config_parser.get('database', 'user'),
    'password': config_parser.get('database', 'password'),
    'database': config_parser.get('database', 'schema')
}
    try:
        print("Before connection attempt")
        connections = pymysql.connect(**config)
        print("Connection successful")
        return connections

    except Exception as e:
        print(f"Error connecting to the database: {e}")
        return None

def fetch_data():
    try:
        connection = get_connection()
        cursor = connection.cursor()

        # Execute SQL queries and fetch data
        query = "SELECT * FROM company"
        cursor.execute(query)
        data = cursor.fetchall()
        column_names = [description[0] for description in cursor.description]
        df = pd.DataFrame(data, columns=column_names)

        # Close the connection
        cursor.close()
        connection.close()

        return data

    except Exception as e:
        st.error(f"Error fetching data: {str(e)}")
        return None

def main():
    st.title("MySQL Database App")

    # Display data from the database
    data = fetch_data()

    if data is not None:
        st.write("Fetched Data:", data)

if __name__ == "__main__":
    main()
