explainTable <- function(table.name) {
  
  o <- list()
  
  # Fetch basic information
  sql <- sprintf('SELECT * FROM `_meta_tables` WHERE display_name = "%s"', table.name)
  
  o$thisTable <- try(myPersonalitySQL(sql), silent = T)
  if (class(o) == "try-error" || nrow(o) == 0) {
    stop("Please check your table name.")
  }
  
  # Check if there are related tables
  sql <- sprintf('SELECT * FROM `_meta_tables` WHERE display_name = "%s"', table.name)
  
  class(o) <- "table.help"
  return(o)
}

print.table.help <- function(x) {
  if (!is.na(x$details)) {
    cat(x$details)
  } else {
    cat("I am sorry. There is no information available about ", x$display_name,".\n")
  }
}