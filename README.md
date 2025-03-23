# Set Up Hotel-Manager
This file will instruct you with how to setup this project <br>
First you would want to download or clone this repository, and also install node.js if it is not already installed

# Setting Up PostgreSQL Server
Once you have cloned or downloaded this project, you want to set up the Postgres Server. To do so first go into pgAdmin4 or the Postgres CLI and create a database named "hotel_management", and have the owner be 'postgres'. Then use the query tool in the GUI or CLI and copy and paste the code from `Hotel-Manager/server/database.sql` into the tool and run the code. This will create all the necessary tables and insert all the data into the DB server. (Please note that if you used a different database name or owner of the database, you will need to change the 'user:' and 'database:' values inside 'Hotel-Manager/server/ds.js' to match your own.)

# Setting Up the Back-End Server
After setting up the Postgres Server, open up the parent directory "Hotel-Manager" and cd into the server directory in a CLI then install the required packages by running the following commands <br><br>
`cd server` <br>
`npm install express pg cors` <br>
`npm install -g nodemon` <br><br>
After installing the packages, go into the ds.js file located at 'Hotel-Manager/server/ds.js' and change the values of 'password:' to match your postgres user password. (Please note from Setting Up PostgreSQL Server, if you used a different user or database name, you must also change those respective fields, as well as 'host:' and 'port:' fields if you are using a different host and port from the default.)

![image](https://user-images.githubusercontent.com/33436865/230741887-c6507f8f-6de5-4b89-87b9-0081618a43e3.png)

After you changed the values inside 'ds.js' to match your own, run <br><br>
`nodemon index` <br><br>
This will start the server. Now the backend server is successfully running and you can continue onto setting up the frontend.

# Setting Up the Front-End Client
Open the parent directory "Hotel-Manager" and cd into the client directory in a CLI then install the required packages by running the following command <br><br>
`cd client` <br>
`npm install react react-bootstrap bootstrap` <br><br>
If after installing the packages, there are vulnerabilities asking you to address the issue, run the following command <br><br>
`npm audit fix --force` <br><br>
Afterwards run <br><br>
`npm start` <br><br>
Now that the client is running, you can go to localhost:3000 to view the webapp.
