#' Initialize connection to myPersonality database server.
#'
#' This function starts your session and sets up your connection to the Cambridge Psychometrics Centre's myPersonality database.
#' Running this function and providing valid user name and password when prompted sets up other data access functions, such as \code{participants()}.
#' The exact names and number of the data access functions depends on your access privileges.
#' 
#' Once the other data access functions have been set up, you can use them to retrieve and filter data (see examples below).
#' For more instructions, please visit \url{https://github.com/vanderlowe/myPersonality/blob/master/README.md}.
#' 
#' @keywords manip
#' @export
#' @param user Your user name (as provided by the Cambridge Psychometrics Centre).
#' @param password Your password (as provided by the Cambridge Psychometrics Centre)
#' @return A printout of data access functions.
#' @note You must contact the Cambridge Psychometrics Centre to obtain access privileges. __You cannot use this package without a valid user name and password.__ If you do not have one, please visit \url{http://mypersonality.org/wiki/doku.php?id=database_use_guidelines} to register as a collaborator.
#' @seealso \link{myPersonalityPackage}, \link{findVariable}
#' @examples
#' # Establish database connection and generate data access functions.
#' \dontrun{
#' myPersonality()
#' }
#' # Show information about participants, including available variables.
#' \dontrun{
#' participants()
#' }
#' # Retrieve age and gender data for all participants.
#' \dontrun{
#' participants("age", "gender")
#' }
#' # Retrieve age and gender data for participants older than 90 years.
#' \dontrun{
#' participants("age > 90", "gender")
#' }

myPersonality <- function(user = NULL, password = NULL) {
  config(user = user, password = password)
  defined.funcs <- myPersonalitySQL("SHOW TABLES", user = user, password = password)[,1]  # MySQL will only show tables to which the user has access
  cat("Currently, the following data access functions are available to you:\n")
  
  for (f in defined.funcs) {
    if (substring(f, 1, 1) == "_") {next}
    f.name <- getDisplayName(f)
    if (!identical(f.name, character(0))) {
      cat(as.character(f.name))  # If _meta_tables
      cat("()\n")  
    }
    
  }
}
