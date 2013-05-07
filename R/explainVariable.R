#' Provide information about specific myPersonality variable.
#'
#' This function describes the speficied variable by fetching additional metainformation about it from the myPersonality database.
#' If a variable exists in multiple tables, the function asks the user to specify which table/variable pair to show.
#' 
#' @param variable.name A character string that specifies the variable of interest.
#' @keywords attribute
#' @export
#' @examples
#' # explainVariable("gender")
#' # explainVariable("userid")  # Multiple tables contain variable 'userid'

explainVariable <- function(variable.name) {
  sql <- sprintf('SELECT * FROM _meta_variables WHERE name = "%s"', variable.name)
  results <- myPersonalitySQL(sql)
  class(results) <- "variable.help"
  return(results)
}

print.variable.help <- function(x) {
  class(x) <- "data.frame"
  if (nrow(x) > 1) {
    cat("The query returns multiple results.\n")
    for (i in 1:nrow(x)) {
      cat(i)
      cat(":", getDisplayName(x$parent_table[i]), "-", x$name[i], "\n")
    }
    n <- readline("Please select one from the list by entering its number: ")
    n <- as.numeric(n)
    if (class(n) != "numeric") {stop("You must enter an integer.")}
  }
  x <- x[n,]
  
  showInfo(x$name, "Variable: ")
  showInfo(getDisplayName(x$parent_table), "Access function: ", "()\n")
  showInfo(x$description, "Description: ","\n")
  showInfo(x$note, "\nDetails:\n")
}
