# Setup
# $ pip install pyyaml
# $ pip install mysql-connector-python
# Create yaml file to contain MySQL connection  (see mysql.yml)
# run this program:
# $ py mysql_example.py

import yaml 
import mysql.connector

connection = ''

with open('mysql.yml') as stream:
    config = yaml.safe_load(stream)
    connection = config['connection'];

cnx = mysql.connector.connect(**connection)
 
if cnx and cnx.is_connected():

    print ("Open connection OK");
    sqlQry = "SELECT * FROM Country LIMIT 5";
    print ("\nRunning SQL: " + sqlQry + "\n\n");

    with cnx.cursor() as cursor:
        result = cursor.execute(sqlQry)
        rows = cursor.fetchall()
        i = 0
        for rows in rows:
            i += 1
            print("Record: {}: {}".format(i,rows))

    print ("\nClose connection");
    cnx.close()

else:
    print("Could not connect to MySQL DB")


    