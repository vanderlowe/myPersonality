listVariables <- function(table.name) {
  db_name <- getDbName(table.name)
  
  # Get table definition from the database
  fields <- myPersonalitySQL(sprintf("SHOW COLUMNS FROM %s", db_name))$Field
  variables <- data.frame(variable = fields, stringsAsFactors = F)
  
  # Get basic variable data from _meta_variables
  sql <- sprintf('SELECT name, description, note FROM _meta_variables WHERE parent_table = "%s"', db_name)
  var.info <- defactor(myPersonalitySQL(sql))
  
  if (!nrow(var.info) == 0) {
    variables <- merge(variables, var.info, by.x = "variable", by.y = "name", all.x = T)
  }
  
  class(variables) <- "variable.list.help"
  return(variables)
}

print.variable.list.help <- function(x) {
  class(x) <- "data.frame"
  notes.flag <- FALSE
  
  if ("note" %in% names(x)) {  
    for (i in 1:nrow(x)) {
      if (x[i, "note"] %in% c(NA,""," ")) {
        x[i, "note"] <- ""
      } else {
        x[i, "note"] <- ""
        x[i, "description"] <- paste(gsub("^ ", "", x[i, "description"]), "*", sep = "")
        notes.flag <- TRUE
      }
    }
    x$note <- NULL
  }
  
  write.table(format(x, justify="left"), row.names=F, col.names=F, quote=F, sep = "    ")
  if (notes.flag) {
    cat("\n* Use command 'explainVariable(\"variable_name_here\")' to see additional variable notes.")
  }
}
