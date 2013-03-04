myPersonality
=============

The `myPersonality` R package provides easy access to a rich dataset collected by [Cambridge Psychometrics Centre](http://www.psychometrics.cam.ac.uk). To learn more about the dataset itself, please visit myPersonality research wiki at http://mypersonality.org. Because the dataset is very large (over 7 million respondents), the easiest way for our collaborators to access the data is through a connection to our database.

# Data access
Because the dataset contains sensitive information, it is made available only to academic researchers by special permission. If you are interested in using the dataset in your research, please [contact us](http://mypersonality.org/wiki/doku.php?id=database_use_guidelines) to request access privileges.

# Installation
We aim to make accessing the dataset as easy as possible, but getting set up will require a few steps. Please follow these instructions carefully. You need to do the setup only once. **Please make sure you have requested (and received) your user name and password from Cambridge Psychometrics Centre before proceeding.**

First, you need to install the `myPersonality` package itself. You can install the prototype version on [github](https://github.com/vanderlowe/myPersonality) using the R package **devtools**:
```
# if you haven't installed 'devtools'
install.packages("devtools") 

# load devtools
library(devtools)

# install 'myPersonality'
install_github('myPersonality',  username='vanderlowe')
```
## Install database drivers (Windows only)
On computers running Windows operating system, `myPersonality` depends on `RODBC` package to establish database connections. `RODBC` needs a working MySQL ODBC driver and a Data Source Name (DSN) to connect to myPersonality database.

### MySQL driver ODBC driver and Data Source Name
0. First, download and install the MySQL ODBC driver from [MySQL developer website](http://dev.mysql.com/downloads/connector/odbc/5.2.html#downloads).
1. Once installed, click the Start menu and type "ODBC" into the search box.
2. Click "Data Source (ODBC)" as it appears in the search results.
3. Click the "System DSN" tab. 
4. Select "Add..." in this tab.
5. Choose "MySQL ODBC 5.2w Driver"
6. In the "Data Source Name:" field, type "myPersonality".
7. In the "TCP/IP Server field:", type "alex.e-psychometrics.com".
8. Leave "Description", "User", "Password", and "Database" fields blank. The "Port:" field should read 3306 by default.
9. Click "OK" to save the DSN.

# Product Backlog
* Contact form to request (a Concerto survey?)
* Entity-relation wrapper function
* Documentation of functions
* Self-documenting database
* Automatic detection of additional tables and variables available in the database
* Production database at sql.mypersonality.org
* Enable compressed connections by default