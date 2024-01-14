# app.py
import os
import streamlit as st
from db_utils import get_connection

os.chdir("C:\Users\HP\Desktop\Movie Prod Companies")

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
