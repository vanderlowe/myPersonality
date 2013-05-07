getDisplayName <- function(db_name) {
  # Get usr-friendly table name based on the actual table name
  sql <- sprintf('SELECT display_name FROM _meta_tables WHERE db_name = "%s"', db_name)
  return(myPersonalitySQL(sql)$display_name)
}

getDbName <- function(display_name) {
  # Get usr-friendly table name based on the actual table name
  sql <- sprintf('SELECT db_name FROM _meta_tables WHERE display_name = "%s"', display_name)
  return(myPersonalitySQL(sql)$db_name)
}

showInfo <- function(x, prefix = "", postfix = "\n") {
  if (is.null(x)) {return(invisible(x))}
  if (!x %in% c(NA, "", " ")) {
    if (!prefix == "") {cat(prefix)}
    cat(x, postfix, sep = "")
  }
}
