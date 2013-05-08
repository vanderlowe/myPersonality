#' Information about myPersonality database tables.
#'
#' This function retrieves metadata about tables from the Cambridge Psychometrics Centre's myPersonality database.
#' However, it is easier to run the data access function without an argument to get the same results (e.g., \code{participants()}).
#' 
#' @param table.name A character string that specifies the table that you are interested in.
#' @keywords attribute
#' @export
#' @seealso \link{myPersonality}, \link{explainVariable}
#' @examples
#' \dontrun{
#' explainTable("address")
#' }

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
  
  o$row_count <- myPersonalitySQL(sprintf("SELECT COUNT(*) FROM %s", o$table.info$db_name))[, 1]
  
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

#' Prints myPersonality table information.
#'
#' This function extends generic print function.
#' 
#' @param x An object returned by explainTable
#' @keywords attribute
#' @method print table.help
#' @S3method print table.help
#' @examples
#' \dontrun{explainTable("address")}

print.table.help <- function(x) {
  info <- x$table.info
  showInfo(info$details, "")
  showInfo(info$note, "\nNOTE: ", "\n\n")
  showInfo(info$citation, "For more information about these data, please see: ")
  showInfo(info$url,"", "\n\n")
  
  cat("This table contains the following variables:\n")
  print(listVariables(info$display_name))
  
  showInfo(x$related, "\nPlease use ", "() to see related data.")
  cat("\nThe table has", x$row_count, "rows.")
}
