createVirtualTable <- function(table.name, variables, ...) {
  o <- list()
  o$where <- list(...) # If user gives additional arguments, treat them as "WHERE" statements
  o$table.name <- table.name
  
  # Get table definition from the database
  o$table.definition <- myPersonalitySQL(sprintf("SHOW COLUMNS FROM %s", table.name))
  
  # Identify primary key
  o$key <- subset(o$table.definition, Key == "PRI")$Field
  
  if (missing(variables)) {
    valid.vars <- paste(o$table.definition$Field, collapse = ", ")
    error.msg <- sprintf(
      "You have not specified which variable to get from the myPersonality database. Please choose at least one of the following: %s.",
      valid.vars
      )
    stop(error.msg)
  } else {
    # Make sure all variable names are found in the table definition
    if (!all(variables %in% o$table.definition$Field)) {
      wrong.var <- variables[!variables %in% o$table.definition$Field]
      stop(sprintf("The variable '%s' is not a valid column in table '%s'.", wrong.var, table.name))
    }
    o$columns <- c(o$key, variables) # Always include primary key for merges later on
  }
  class(o) <- "virtual.table"
  return(o)
}

print.virtual.table <- function(x) {
  cat(generateSQL(x),"\n")
}

"+.virtual.table" <- function(x,y) {
  cat("This needs to be fixed")
}

getData <- function(x) {
  suppressPackageStartupMessages(require(data.table))
  sql.data <- data.table(myPersonalitySQL(generateSQL(x)))
  setkeyv(sql.data, x$key)
  return(sql.data)
}
