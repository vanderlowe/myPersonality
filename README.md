myPersonality
=============

The 'myPersonality' R package provides easy access to a rich dataset created by [Cambridge Psychometrics Centre](http://www.psychometrics.cam.ac.uk). To learn more about the dataset itself, please visit [myPersonality research wiki](http://mypersonality.org). Because the dataset contains millions of respondents, the easiest way to access the data is through a database connection. The _myPersonality_ package provides a set of utility functions to request specific variables of interest from the data.

# Data access
The dataset is only available by special permission to our academic collaborators. If you are interested in using the dataset in your research, please [contact us](http://mypersonality.org/wiki/doku.php?id=database_use_guidelines) to request access privileges. **Please make sure you have received your user name and password from Cambridge Psychometrics Centre before proceeding with installation.**

# Installation
Please follow these instructions carefully and to the letter. You need to do the setup only once.

## Install database drivers (Windows users only)
On computers running Windows operating system, _myPersonality_ depends on _RODBC_ package to establish database connections. This requires the installation of a _MySQL ODBC driver_ and _Data Source Name_ (DSN) on your computer.

### MySQL ODBC driver
Please download and install the _MySQL ODBC driver_ from [MySQL developer website](http://dev.mysql.com/downloads/connector/odbc/5.2.html#downloads). On the download page, find _Windows (x86, 64-bit), MSI Installer_, if you are running R in a 64-bit environment. For a 32-bit compatible MySQL driver, please choose _Windows (x86, 32-bit), MSI Installer
Connector-ODBC_.
* If you are not sure whether your PC running the 32-bit or 64-bit version of Windows, Microsoft has provided [information on how to find it out](http://windows.microsoft.com/en-GB/windows7/find-out-32-or-64-bit).

### Data Source Name
1. Once you have installed the _MySQL ODBC driver_, click the Windows Start menu and type `ODBC` into the search box. (For 32-bit Windows machines, please use `odbcad32` instead.)
2. Click on "Data Source (ODBC)" in the search results. Wait for the program to open.
3. Select the "System DSN" tab. 
4. Click the "Add..." button.
5. Choose "MySQL ODBC 5.2w Driver".
6. In the "Data Source Name:" field, type `myPersonality`.
7. In the "TCP/IP Server field:", type `alex.e-psychometrics.com`. **Note to Michal and David: The production server details go here when the server is up.**
8. Leave "Description", "User", "Password", and "Database" fields blank. The "Port:" field should read 3306 by default.
9. Optionally, click "Details >>" and check the box "Use compression". This will improve data download speeds.
10. Click "OK" to save the DSN.

## Install the `myPersonality` package itself
The _myPersonality_ package is installed using the _[devtools](https://github.com/hadley/devtools/)_ package:
```
install.packages("devtools") 
library(devtools)
install_github('myPersonality',  username = 'vanderlowe')
```

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

First, you should be prompted for your user name and password. Once you enter these, you should see the following message (or similar, as the available functions depend on the extent of your access privileges):
```
Currently, the following data access functions are available to you:
adress()
participants()
satisfaction_with_life()
```
Each of these functions gives you access to data in our database.

## Exploring the dataset
Let's start with basic information about participants in myPersonality database. Go ahead and type:
```
participants()
```
You should see the following message:
```
This table contains basic demographic information about the myPersonality participants.
For more information about these data, please see: Kosinski, M., Stillwell D. J., & Graepel, T. (2013). Private traits and attributes are predictable from digital records of human behavior. Proceedings of the National Academy of Sciences, 110(15), 5802-5805.
http://mypersonality.org

This table contains the following variables:
age                                                           
birthday                                                      
gender                 Gender of the user*                    
interested_in          Interested In*                         
locale                 language version of Facebook interface*
mf_dating              Meeting other for dating               
mf_friendship          Meeting other for friendship           
mf_networking          Meeting other for networking           
mf_random              Meeting other for random play          
mf_relationship        Meeting other for relationship                                    
mf_whatever            Meeting other for whatever I can get   
network_size           Number of friends*                     
relationship_status    Relationship status*                   
timezone               User's Timezone                        
userid                 Unique user identifier                 

* Use command 'explainVariable("variable_name_here")' to see additional variable notes.
The table has 4282858 rows.
```
Since we did not specify which variable (i.e., a field in the database) we wanted, the function provided us with information about the participant data, including a list of available variables.

You may have noticed that some of the variable descriptions are marked with an asterisk. This means that there is additional information available about this variable. The 'explainVariable' function allows you to find out this extra information. Try typing:
```
explainVariable("gender")
```
The results should look something like this:
```
Variable: gender
Access function to retrieve data: participants('gender')
Description: Gender of the user

Details:
1=female, 0=male
```
With this additional information, we can tell that participants whose gender is coded as `1` are female. For your convenience, the `Access function` line provides you the code to retrieve the data.

To find variables that might be interesting to you, you can use the `findVariables` function to search the dataset. Let's say that you are interested in the zip code of the participants. To find out if the dataset contains zip codes, you can type:
```
findVariable("zip")
```
This function will search the variable name, description, and additional notes for  instances of the word 'zip' and return the results for your inspection. Please note that if there are multiple results, the function will stop to ask you to indicate which result you would like to see in detail:
```
The query returns multiple results.
1: address - current_location_zip 
2: address - hometown_location_zip 
Please select one from the list by entering its number:
```
If you are interested in the hometown zip (instead of the current location), you would type `2` on your keyboard, producing information about variable `hometown_location_zip`.
```
Variable: hometown_location_zip
Access function: address('hometown_location_zip')
```

## Loading data
Let's say we want to get the age, gender, and relationship status of all users and assign it to variable `people`. For this, you would type:
```
people <- participants("age", "gender", "relationship_status")
```
You can provide as many or as few variable names as you wish. However, keep in mind that more variables mean more data to transfer and requesting many variables at a time may be very slow.

### Filtering data
You can also easily filter the results by specifying a criterion after the variable name. Let's get the same data as above for participants over the age of 90 and assign the results to variable `elderly`.
```
elderly <- participants("age > 90", "gender", "relationship_status")
```

## Merging data
The results from different tables can be combined. Let's get data for all myPersonality participants over the age of 90 who live in smallish communities with a population greater than 1000, but less than 10,000. Since we already have the variable `elderly` from the example above, we only need to request the necessary location data.
```
location <- address("current_location_city", "population > 1000", "population < 10,000")
elderly.in.small.towns <- merge(elderly, location)
```

# Example usage: Advanced users
Behind the scenes, all data access is done via the `myPersonalitySQL` function. It allows you to execute SQL queries on the database (only read-only queries are allowed).
```
elderly.in.Miami <- myPersonalitySQL('
  SELECT demog.age, demog.gender, demog.relationship_status, address.current_location_city 
  FROM demog 
  LEFT JOIN address 
  ON demog.userid = address.userid 
  WHERE demog.age > 90 AND address.current_location_city = "Miami"
')
```
Please note that the query must be enclosed in *single* quotation marks.

# Known ~~bugs~~ features
* You may encounter "Error in fetch(key) : internal error -3 in R_decompress1" if trying to access documentation immediately after installing `myPersonality` package. This is a [known issue with R](http://stackoverflow.com/questions/10373098/error-in-fetchkey-internal-error-3-in-r-decompress1). Restarting R will resolve the issue.