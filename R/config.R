config <- function(user = NULL, password = NULL) {
  
  # Set default server address and database name
  Sys.setenv("myPersonality_host" = "alex.e-psychometrics.com")
  Sys.setenv("myPersonality_database" = "cpw_myPersonality")
  
  if (interactive()) {
    # R is running in interactive mode.
    # If user name is provided as an argument, use it.
    if (!is.null(user)) {
      Sys.setenv("myPersonality_user" = user)
    } else {
      # User name has not been supplied as an argument.
      if (Sys.getenv("myPersonality_user") == "") {
        # If user name has not been set in env vars, prompt for it.
        uid <- readline("Please enter your user name: ")
        Sys.setenv("myPersonality_user" = uid)
      } else {
        # Environment variable is already set, nothing to do
      }
    }
    
    # If password is provided as an argument, use it.
    if (!is.null(password)) {
      Sys.setenv("myPersonality_password" = password)
    } else {
      # Password has not been supplied as an argument.
      if (Sys.getenv("myPersonality_password") == "") {
        # If user name has not been set in env vars, prompt for it.
        pwd <- readline("Please enter your password: ")
        Sys.setenv("myPersonality_password" = pwd)
      } else {
        # Password is already set, nothing to do
      }
    }

  } else {
    # Set dummy user for non-interactive use.
    # Note: Dummy user has no privileges beyond reading meta tables
    Sys.setenv("myPersonality_user" = "connection_test")
    Sys.setenv("myPersonality_password" = "foobar")
  }

  if (interactive()) {
    # Set up data access functions
    source(system.file("tableDefinitions.R", package = "myPersonality", mustWork = T)) 
  }
}
