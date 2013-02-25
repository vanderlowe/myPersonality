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
  
  myPersonality_host <- Sys.getenv("myPersonality_host")
  myPersonality_user <- Sys.getenv("myPersonality_user")
  myPersonality_password <- Sys.getenv("myPersonality_password")
  myPersonality_database <- Sys.getenv("myPersonality_database")
    
  # Check whether the user is on a Windows or Mac system
  # This is needed, because Mac users will connect via RMySQL
  # and Windows users via RODBC
  
  if (Sys.info()[1] == "Darwin") {
    # Access for Mac users
    require(RMySQL)
    con <- dbConnect("MySQL", host = myPersonality_host, user = myPersonality_user, password = myPersonality_password, dbname = myPersonality_database)
    results <- dbGetQuery(con, query)
    dbDisconnect(con)
    return(results)
  } else {
    # PC code in here
    require(RODBC)
    channel <- odbcConnect("UnifiedServer")
    sqlQuery(channel, sprintf("USE %s;", magic_db))
    results <- sqlQuery(channel, query)
    odbcClose(channel)
    return(results)
  }
  
}
