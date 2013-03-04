myPersonality
=============

The _myPersonality_ R package provides easy access to a rich dataset by the same name that was created by [Cambridge Psychometrics Centre](http://www.psychometrics.cam.ac.uk). To learn more about the dataset itself, please visit [myPersonality research wiki](http://mypersonality.org). Because the dataset contains millions of respondents, the easiest way to access the data is through a database connection. The _myPersonality_ package provides a set of utility functions to request specific variables of interest from the data.

# Data access
The dataset is only available by special permission to our academic collaborators. If you are interested in using the dataset in your research, please [contact us](http://mypersonality.org/wiki/doku.php?id=database_use_guidelines) to request access privileges. **Please make sure you have received your user name and password from Cambridge Psychometrics Centre before proceeding with installation.**

# Installation
Please follow these instructions carefully. You need to do the setup only once.

First, you need to install the _myPersonality_ package itself. You can install the prototype version available on [github](https://github.com/vanderlowe/myPersonality) using _[devtools](https://github.com/hadley/devtools/)_ package:
```
install.packages("devtools") 
library(devtools)
install_github('myPersonality',  username='vanderlowe')
```
## Install database drivers (Windows users only)
On computers running Windows operating system, _myPersonality_ depends on _RODBC_ package to establish database connections. This requires the installation of a _MySQL ODBC driver_ and _Data Source Name_ (DSN) on your computer.

### MySQL ODBC driver
Please download and install the _MySQL ODBC driver_ from [MySQL developer website](http://dev.mysql.com/downloads/connector/odbc/5.2.html#downloads). On the download page, find _Windows (x86, 64-bit), MSI Installer_. It should work for most users.

### Data Source Name
1. Once you have installed the _MySQL ODBC driver_, click the Windows Start menu and type `ODBC` into the search box.
2. Click on "Data Source (ODBC)" in the search results. Wait for the program to open.
3. Select the "System DSN" tab. 
4. Click the "Add..." button.
5. Choose "MySQL ODBC 5.2w Driver".
6. In the "Data Source Name:" field, type `myPersonality`.
7. In the "TCP/IP Server field:", type `alex.e-psychometrics.com`. **Note to Michal and David: The production server details go here when the server is up.**
8. Leave "Description", "User", "Password", and "Database" fields blank. The "Port:" field should read 3306 by default.
9. Optionally, click "Details >>" and check the box "Use compression". This will improve data download speeds.
10. Click "OK" to save the DSN.

# Example usage: Novice users
At the start of each session, you must load the _myPersonality_ package to make the functions available in R. You can do this by typing:
```
library(myPersonality)
```

## Testing the connection
To test that your connection works, type the following:
```
myPersonality()
```

First, you should be prompted for your user name and password. Once you enter these, you should see the following message:
```
Currently, the following functions are available:
participants()
adress()
employers()
```
Each of these functions gives you access to data in our database.

## Loading data
Let's start with basic information about participants in myPersonality database. To see what variables are available, please type:
```
participants()
```
You should see the following message.
```
You must request at least one variable.
You can choose one or more of the following:
userid
gender
birthday
age
relationship_status
interested_in
mf_relationship
mf_dating
mf_random
mf_friendship
mf_whatever
mf_networking
locale
network_size
timezone
```
Since we did not specify which variable (i.e., a field in the database) we wanted, the function provided us with a helpful list of available variables.

Let's say we want to get the age, gender, and relationship status of all users and assign it to variable `people`. For this, you would type:
```
people <- participants("age", "gender", "relationship_status")
```
You can provide as many or as few variable names as you wish. However, keep in mind that more variables mean more data to transfer and requesting many variables at a time may be very slow.

### Filtering data
You can also easily filter the results by providing the criteria with the variable name. Let's get the same data as above for participants over the age of 90 and assign the results to variable `elderly`.
```
elderly <- participants("age > 90", "gender", "relationship_status")
```

## Merging data
The results from different tables can be combined. Let's get data for all myPersonality participants over the age of 90 who live in cities with a population greater than 100, but greater than 10,000. Since we already have the variable `elderly` from the example above, we only need to request the necessary location data.
```
location <- address("current_location_city", "population > 100", "population < 10,000")
elderly.in.small.towns <- merge(elderly, location)
```

# Example usage: Advanced users
All data access is done via the `myPersonalitySQL` function. It allows you to execute SQL queries on the database (only read-only queries are allowed).
```
elderly.in.Miami <- myPersonalitySQL("
  SELECT demog.age, demog.gender, demog.relationship_status, address.current_location_city 
  FROM demog 
  LEFT JOIN address 
  ON demog.userid = address.userid 
  WHERE demog.age > 90 AND address.current_location_city = 'Miami'"
)
```

# Product Backlog
* Self-documenting database
* Automatic detection of additional tables and variables available in the database
* Production database at sql.mypersonality.org