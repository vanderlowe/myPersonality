#' Set connection details to environment variables.
#'
#' This function sets user name, password, host, and database name to environment variables
#' for later use.
#' 
#' @param query SQL query string to be executed. Defaults to "SHOW TABLES;"
#' @keywords manip
#' @examples
#' config()

config <- function() {
  Sys.setenv("myPersonality_host" = "alex.e-psychometrics.com")
  Sys.setenv("myPersonality_database" = "cpw_myPersonality")
  
  uid <- readline("Please enter your user name: ")
  Sys.setenv("myPersonality_user" = uid)
  
  pwd <- readline("Please enter your password: ")
  Sys.setenv("myPersonality_password" = pwd)
}

localConfig <- function() {
  Sys.setenv("myPersonality_host" = "127.0.0.1")
  Sys.setenv("myPersonality_database" = "myPersonality_dev")
  Sys.setenv("myPersonality_user" = "root")
  Sys.setenv("myPersonality_password" = "")
}