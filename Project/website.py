import psycopg2
import streamlit as st
from datetime import datetime
import pandas as pd

# Change parameters according to your newly created DB
def connect_to_db():
    conn = psycopg2.connect(
        dbname="F1_DATA",
        user="postgres",
        password="rishabh",
        host="localhost",
        port="5432"
    )
    return conn

def execute_query(query):
    conn = connect_to_db()
    cursor = conn.cursor()
    cursor.execute(query)
    result = cursor.fetchall()
    description = cursor.description
    conn.close()
    return result, description

def main():
    st.set_page_config(layout="centered", page_title="F1 Database 🏎️", page_icon="🛞")

    st.title("F1 Database 🏎️")

    tab1, tab2, tab3 = st.tabs(["Driver Information", "Constructor Information", "Circuit Information"])

    with tab1:
        st.header("Find Drivers")

        nationality = st.selectbox("Nationality", ["Brazilian", "British", "French", "German", "Italian", "Spanish"])

        start_year, end_year = st.slider("Select DOB Range", 1950, datetime.today().year, (1950, datetime.today().year))

        start_date = datetime(start_year, 1, 1)
        end_date = datetime(end_year, 12, 31)

        driver_query = "SELECT forename, surname, dob, nationality FROM drivers WHERE 1=1"
        if nationality:
            driver_query += f" AND nationality = '{nationality}'"
        if start_year and end_year:
            driver_query += f" AND dob BETWEEN '{start_date}' AND '{end_date}'"

        driver_data, description = execute_query(driver_query)
        if driver_data:
            df = pd.DataFrame(driver_data, columns=['Forename', 'Surname', 'D.O.B.', 'Nationality'])
            st.dataframe(df)
        else:
            st.write("No data available for the selected date range.")


    with tab2:
        st.header("Find Constructors")

        nationality = st.selectbox("Nationality", ["British", "French", "German", "Italian", "Japanese"])

        constructor_query = f"SELECT name, nationality, url FROM constructors WHERE nationality = '{nationality}'"
        constructor_data, description = execute_query(constructor_query)
        if constructor_data:
            df = pd.DataFrame(constructor_data, columns=['Name', 'Nationality', 'URL'])
            st.dataframe(df)
        else:
            st.write("No data available for the selected country.")

    with tab3:
        st.header("Find Circuits")

        country = st.text_input("Enter Country Name")

        circuit_query = f"SELECT name, city, country, url FROM circuits, location WHERE circuits.location_id = location.location_id AND country = '{country}'"
        circuit_data, description = execute_query(circuit_query)
        if circuit_data:
            df = pd.DataFrame(circuit_data, columns=['Name', 'City', 'Country', 'URL'])
            st.dataframe(df)
        else:
            st.write("No data available for the selected country.")

    

    # Sidebar code
    st.sidebar.title(":red[Overview]")
    st.sidebar.write("""Formula 1, also known as F1, is the top tier of single-seater auto racing governed by the Fédération Internationale de l'Automobile (FIA) and owned by the Formula One Group. \
                     Established in 1950, the FIA Formula One World Championship is a leading global racing event. \
                     The term "formula" denotes the regulations that all competing cars must adhere to. \
                     Each Formula One season comprises a sequence of races, referred to as Grands Prix, held on specialized circuits and occasionally on public streets across the globe.""")
    st.sidebar.subheader(":red[Content]")
    st.sidebar.write("The database consists of all information on the Formula 1 races, drivers, constructors, qualifying, \
                     circuits, lap times, pit stops, championships from 1950 till the latest 2023 season.")
    st.sidebar.subheader(":red[Inspiration]")
    st.sidebar.write("\"Races are won at the track. Championships are won at the factory.\" - Mercedes (2019)")
    st.sidebar.write("")
    st.sidebar.write("""With the amount of data being captured, analyzed and used to design, build and drive the Formula 1 cars is astounding. \
                     It is a global sport being followed by millions of people worldwide and it is very fascinating to see drivers \
                     pushing their limit in these vehicles to become the fastest racers in the world!""")


if __name__ == "__main__":
    main()
