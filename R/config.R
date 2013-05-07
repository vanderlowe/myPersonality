config <- function(user, password) {
  
  Sys.setenv("myPersonality_host" = "alex.e-psychometrics.com")
  Sys.setenv("myPersonality_database" = "cpw_myPersonality")
  
  if (!interactive()) {
    Sys.setenv("myPersonality_user" = "connection_test")
    Sys.setenv("myPersonality_password" = "foobar")
  }
  
  if (Sys.getenv("myPersonality_user") == "" | interactive()) {
    if (missing(user)) {
      uid <- readline("Please enter your user name: ")
      Sys.setenv("myPersonality_user" = uid)
    } else {
      Sys.setenv("myPersonality_user" = user)
    }
    
  }
  
  if (Sys.getenv("myPersonality_password") == "" | interactive()) {
    if (missing(password)) {
      pwd <- readline("Please enter your password: ")
      Sys.setenv("myPersonality_password" = pwd)
    } else {
      Sys.setenv("myPersonality_password" = password)
    }
  }
  
  if (interactive()) {
    source(system.file("tableDefinitions.R", package = "myPersonality", mustWork = T))
  }
}
