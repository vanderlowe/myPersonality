#' Execute SQL query on myPersonality database server.
#'
#' This function executes SQL queries on the Cambridge Psychometrics Centre database. It is meant for advanced users only.
#' By default, users only have privileges for queries using SELECT statements.
#' 
#' @param query SQL query string to be executed. Defaults to "SHOW TABLES;"
#' @keywords manip
#' @import data.table
#' @export
#' @return A \code{data.table} object.
#' @examples
#' \dontrun{
#' myPersonalitySQL("SELECT * FROM demog")
#' }

myPersonalitySQL <- function(query = "SHOW TABLES;", user = NULL, password = NULL) {
  
  if (!interactive()) {return(NULL)}
  
  # Check whether necessary environment variables exist. If not, run configuration.
  if (
      Sys.getenv("myPersonality_user") %in% c("", "connection_test") &
      Sys.getenv("myPersonality_password") %in% c("", "foobar") &
      interactive()
    ) {
    config(user, password)
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
    
    # Log query before execution (helps to identify user queries that fail to execute)
    dbGetQuery(con, sprintf("INSERT INTO `_usage_log` (query, user) VALUES ('%s','%s')", query, myPersonality_user))
    
    # Run query with timer
    timer <- system.time(results <- dbGetQuery(con, query))
   
    # Log query execution time after execution (helps to identify queries could be optimized)
    dbGetQuery(con, sprintf("UPDATE `_usage_log` SET `execution_time` = %f WHERE `id` = (SELECT MAX(`id`) AS `id` FROM (SELECT `id` FROM `_usage_log` WHERE `user` = '%s') AS x)", timer[3], myPersonality_user))
    
    dbDisconnect(con)
    return(results)
    
  } else {
    # PC code in here
    if (!require(RODBC)) {
      # Install RODBC if not available
      install.packages("RODBC")
      require(RODBC)
    }
    
    channel <- odbcConnect("myPersonality", uid = myPersonality_user, pwd = myPersonality_password)
    sqlQuery(channel, sprintf("USE %s;", myPersonality_database)) # Use the right database
    
    # Log query before execution (helps to identify user queries that fail to execute)
    sqlQuery(channel, sprintf("INSERT INTO `_usage_log` (query, user) VALUES ('%s','%s')", query, myPersonality_user))
        
    # Run query with timer
    timer <- system.time(results <- sqlQuery(channel, query))
    
    # Log query execution time after execution (helps to identify queries could be optimized)
    sqlQuery(channel, sprintf("UPDATE `_usage_log` SET `execution_time` = %f WHERE `id` = (SELECT MAX(`id`) AS `id` FROM (SELECT `id` FROM `_usage_log` WHERE `user` = '%s') AS x)", timer[3], myPersonality_user))
    
    odbcClose(channel)
    return(results)
  }
}
