explainTable <- function(table.name) {
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
    o$related <- o$related[, 1]
  }
  
  class(o) <- "table.help"
  return(o)
}

listVariables <- function(table.name) {
  db_name <- getDbName(table.name)
  
  # Get table definition from the database
  fields <- myPersonalitySQL(sprintf("SHOW COLUMNS FROM %s", db_name))$Field
  variables <- data.frame(variable = fields)
  
  # Get basic variable data from _meta_variables
  sql <- sprintf('SELECT name, description, note FROM _meta_variables WHERE parent_table = "%s"', db_name)
  var.info <- myPersonalitySQL(sql)
  if (!nrow(var.info) == 0) {
    variables <- merge(variables, var.info, by.x = "variable", by.y = "name", all.x = T)
  }
  
  class(variables) <- "variable.list.help"
  return(variables)
}

showInfo <- function(x, prefix = "", postfix = "\n") {
  if (!is.na(x)) {
    if (!prefix == "") {cat(prefix)}
    cat(x, postfix, sep = "")
  }
}

print.table.help <- function(x) {
  info <- x$table.info
  showInfo(info$details, "\n\n")
  showInfo(info$note, "\nNOTE: ", "\n\n")
  showInfo(info$citation, "For more information about these data, please see: ")
  showInfo(info$url,"", "\n\n")
  
  cat("This table contains the following variables:\n")
  print(listVariables(info$display_name))
  
  showInfo(x$related, "\n\nPlease use ", "() to see related data.")
}

print.variable.list.help <- function(x) {
  class(x) <- "data.frame"
  notes.flag <- FALSE
  
  if ("note" %in% names(x)) {  
    for (i in 1:nrow(x)) {
      if (is.na(x[i, "note"])) {
        x[i, "note"] <- ""
      } else {
        x[i, "note"] <- ""
        x[i, "description"] <- paste(gsub("^ ", "", x[i, "description"]), "*", sep = "")
      }
      notes.flag <- TRUE
    }
    x$note <- NULL
  }
  
  write.table(format(x, justify="left"), row.names=F, col.names=F, quote=F, sep = "    ")
  if (notes.flag) {
    cat("* Use command 'explainVariable(\"variable_name_here\")' to see additional variable notes.")
  }
}
