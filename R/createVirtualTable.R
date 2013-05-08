createVirtualTable <- function(table.name, ...) {
  # Create a placeholder list for object data
  o <- list()
  o$table.name <- table.name
  o$display.name <- getDisplayName(table.name)
  
  # Get table definition from the database
  o$table.definition <- myPersonalitySQL(sprintf("SHOW COLUMNS FROM %s", table.name))
  valid.columns <- o$table.definition$Field
  
  # Identify primary key
  o$key <- as.character(subset(o$table.definition, Key == "PRI")$Field)
  
  # Identify columns and WHERE statements from arguments supplied by user
  args <- processFunctionArguments(...)
  
  # If no arguments were given, display brief help instead.
  if (is.null(args)) {
    print(explainTable(o$display.name))
    return(invisible(NULL))
  }
  
  o$columns <- c(o$key, args$columns) # Always include primary key for merges later on.
  # Note: Cases in which there is no primary key will be handled downstream by getData()
  
  if (!all(o$columns %in% valid.columns)) {
    wrong.columns <- paste(setdiff(o$columns, valid.columns), collapse = ", ")
    error.msg <- sprintf("\nThe following are not valid variable names:\n%s", wrong.columns)
    stop(error.msg)
  }
  
  o$where <- args$where
  
  class(o) <- "virtual.table"
  results <- getData(o)
  return(results)
}

print.virtual.table <- function(x) {
  cat(generateSQL(x),"\n")
}

getData <- function(x) {
  sql.data <- data.table(myPersonalitySQL(generateSQL(x)))
  if (!identical(x$key, character(0))) {
    setkeyv(sql.data, x$key)
  } else {
    # There is no primary key for the table
  }
  
  return(sql.data)
}
