#' Execute SQL query on myPersonality database server.
#'
#' This function executes SQL queries on the Cambridge Psychometrics Centre database.
#' \code{myPersonalitySQL} automatically uses the right R package for database access,
#' depending on your operating system (RMySQL for Mac and RODBC for Windows).
#' 
#' @param query SQL query string to be executed. Defaults to "SHOW TABLES;"
#' @keywords manip
#' @export
#' @examples
#' myPersonality()
#' myPersonality("SELECT * FROM demog")

myPersonalitySQL <- function(query = "SHOW TABLES;") {
  
  # Check whether necessary environment variables exist. If not, run configuration.
  if (all(
        c(Sys.getenv("myPersonality_user"), 
          Sys.getenv("myPersonality_password"),
          Sys.getenv("myPersonality_host"),
          Sys.getenv("myPersonality_database")
          ) == "")
      ) {
    config()
  }
  
  # Get environment variables needed for db access
  myPersonality_host <- Sys.getenv("myPersonality_host")
  myPersonality_user <- Sys.getenv("myPersonality_user")
  myPersonality_password <- Sys.getenv("myPersonality_password")
  myPersonality_database <- Sys.getenv("myPersonality_database")
    
  # Check whether the user is on a Windows or Mac system.
  # This is needed, because Mac users will connect via RMySQL
  # and Windows users via RODBC.
  
  if (Sys.info()[1] == "Darwin") {
    # Access for Mac users
    if (!require(RMySQL)) {
      # Install RMySQL if not available
      install.packages("RMySQL")
      require(RMySQL)
    }
    
    # Establish MySQL connection
    # client.flag=32 enables compression
    con <- dbConnect("MySQL", host = myPersonality_host, user = myPersonality_user, password = myPersonality_password, dbname = myPersonality_database, client.flag=32)
    results <- dbGetQuery(con, query)
    dbDisconnect(con)
    return(results)
    
  } else {
    # PC code in here
    if (!require(RODBC)) {
      # Install RODBC if not available
      install.packages("RMySQL")
      require(RODBC)
    }
    
    channel <- odbcConnect("myPersonality")
    sqlQuery(channel, sprintf("USE %s;", myPersonality_database)) # Use the right database
    results <- sqlQuery(channel, query)
    odbcClose(channel)
    return(results)
  }
  
}
