Steps to setup Postgresql database and run website locally -

1. On PGAdmin, use the query tool to open a script and select the "create.sql" file. Click on run. This will create all the required tables.
2. On PGAdmin, open the PSQL tool in the same way we opened the query tool. This should open a terminal. Now open "load.sql" using a notepad app. Make sure to change the absolute path to the location of the files on your system. Copy the whole script and paste it on the PSQL terminal and hit Enter. This will load all the data.
3. Next, use the query tool to run "UPDATE.sql" just like we did in step 1. This should normalize the database to the required form.

Alternatively, instead of running above three steps. You can restore "f1_database_backup".

4. To run the webapp -
    4.1. Open the folder in a code editor like VSCode.
    4.2. Make sure the terminal is pointing to this directory. Type "pip install -r requirements.txt" on the terminal and hit enter. This should install all the requirements.
    4.3. To run the webapp, type "streamlit run website.py" and hit enter. A new browser window should pop up with the webapp running on localhost.
