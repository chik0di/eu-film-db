# app.py
import streamlit as st
import os
import pymysql
import pandas as pd

def get_connection():
    try:
        config = {
        'host': os.environ.get('myhost'),
        'user': os.environ.get('user'),
        'password': os.environ.get('password'),
        'database': os.environ.get('schema')
    }
   
        print("Before connection attempt")
        connection = pymysql.connect(**config)
        print("Connection successful")
        return connection

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

        return df

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
