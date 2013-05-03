createVirtualTable <- function(table.name, ...) {
  
  # Create a placeholder list for object data
  o <- list()
  o$table.name <- table.name
    
  # Get table definition from the database
  o$table.definition <- myPersonalitySQL(sprintf("SHOW COLUMNS FROM %s", table.name))
  valid.columns <- o$table.definition$Field
  
  # Identify primary key
  o$key <- as.character(subset(o$table.definition, Key == "PRI")$Field)
  
  # Identify columns and WHERE statements from arguments supplied by user
  args <- processFunctionArguments(...)
  if (is.null(args)) {
    null.msg <- sprintf("You must request at least one variable.\nYou can choose one or more of the following:\n%s", paste(valid.columns, collapse = "\n"))
    message(null.msg)
    return(invisible(NULL))
  }
  
  o$columns <- c(o$key, args$columns) # Always include primary key for merges later on
  
  if (!all(o$columns %in% valid.columns)) {
    wrong.columns <- paste(setdiff(o$columns, valid.columns), collapse = ", ")
    error.msg <- sprintf("\nThe following are not valid variable names:\n%s", wrong.columns)
    stop(error.msg)
  }
  
  o$where <- args$where
  
  class(o) <- "virtual.table"
  return(getData(o))
}

print.virtual.table <- function(x) {
  cat(generateSQL(x),"\n")
}

getData <- function(x) {
  suppressPackageStartupMessages(require(data.table))
  sql.data <- data.table(myPersonalitySQL(generateSQL(x)))
  if (!identical(x$key, character(0))) {
    setkeyv(sql.data, x$key)
  } else {
    # There is no primary key for the table
  }
  
  return(sql.data)
}
