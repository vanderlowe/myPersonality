#' Set connection details to environment variables.
#'
#' This function sets user name, password, host, and database name to environment variables
#' for later use.
#' 
#' @param query SQL query string to be executed. Defaults to "SHOW TABLES;"
#' @keywords manip
#' @examples
#' #config()

config <- function() {
  
  Sys.setenv("myPersonality_host" = "alex.e-psychometrics.com")
  Sys.setenv("myPersonality_database" = "cpw_myPersonality")
  
  if (!interactive()) {
    Sys.setenv("myPersonality_user" = "connection_test")
    Sys.setenv("myPersonality_password" = "foobar")
  }
  
  if (Sys.getenv("myPersonality_user") == "" | interactive()) {
    uid <- readline("Please enter your user name: ")
    Sys.setenv("myPersonality_user" = uid)
  }
  
  if (Sys.getenv("myPersonality_password") == "" | interactive()) {
    pwd <- readline("Please enter your password: ")
    Sys.setenv("myPersonality_password" = pwd)
  }
}
