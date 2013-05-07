#' Provide information about specific myPersonality database tables.
#'
#' This function retrieves data from the Cambridge Psychometrics Centre's myPersonality database.
#' 
#' @param table.name A character string that specifies the table that you are interested in.
#' @keywords attribute
#' @export
#' @examples
#' # explainTable("address")

explainTable <- function(table.name) {
  if (missing(table.name)) {
    stop("You must provide a table name.")
  }
  o <- list()
  
  # Fetch basic information
  sql <- sprintf('SELECT * FROM `_meta_tables` WHERE display_name = "%s"', table.name)
  
  o$table.info <- try(myPersonalitySQL(sql), silent = T)
  if (class(o) == "try-error" || nrow(o$table.info) == 0) {
    stop("Please check your table name.")
  }
  
  # Check if there are related tables
  sql <- sprintf('SELECT child_table FROM `_meta_related_tables` WHERE parent_table = "%s"', o$table.info$db_name)
  o$related <- myPersonalitySQL(sql)
  if (nrow(o$related) == 0) {
    o$related <- NA
  } else {
    o$related <- getDisplayName(o$related[, 1])
  }
  
  class(o) <- "table.help"
  return(o)
}

# Internal function to display table help objects.
print.table.help <- function(x) {
  info <- x$table.info
  showInfo(info$details, "")
  showInfo(info$note, "\nNOTE: ", "\n\n")
  showInfo(info$citation, "For more information about these data, please see: ")
  showInfo(info$url,"", "\n\n")
  
  cat("This table contains the following variables:\n")
  print(listVariables(info$display_name))
  
  showInfo(x$related, "\nPlease use ", "() to see related data.")
}
