# app.py
import streamlit as st
import os
import mysql.connector

def get_connection():
    try:
        config = {
        'host': os.environ.get('myhost'),
        'user': os.environ.get('user'),
        'password': os.environ.get('password'),
        'database': os.environ.get('schema')
    }
   
        print("Before connection attempt")
        connection = mysql.connector.connect(**config)
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
