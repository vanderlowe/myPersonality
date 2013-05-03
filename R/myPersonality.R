#' Retrieve data from the myPersonality database server.
#'
#' This function retrieves data from the Cambridge Psychometrics Centre's myPersonality database.
#' 
#' @param query A character string that specifies the variables that you are interested in. If left blank, it will show the available options.
#' @keywords manip
#' @export
#' @examples
#' participants()
#' participants("age > 90")

myPersonality <- function() {  
  defined.funcs <- myPersonalitySQL("SELECT display_name as func FROM `_meta_tables` ORDER BY func")
  cat("Currently, the following data are available:\n")
  
  for (f in defined.funcs$func) {
    cat(f)
    cat("()\n")
  }
}
