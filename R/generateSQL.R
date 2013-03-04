generateSQL <- function(x) {
  if (!inherits(x, "virtual.table")) {
    stop("The function requires a 'virtual.table' object.")
  }
  
  if (is.null(x$where)) {
    where <- ""
  } else {
    where <- generateWHERE(x$where, x$table.name)
  }
  sql.cmd <- sprintf("SELECT %s FROM %s %s", paste(x$table.name, unique(x$columns), sep = ".", collapse = ","), x$table.name, where)
  
  return(sql.cmd)
}

generateWHERE <- function(x, table.name) {
  
  if (length(x) == 0) {return("")}
  
  where <- "WHERE "
  for (i in 1:length(x)) {
    value <- x[i]
    thisWhere <- paste(table.name, value, sep =".")
    if (i > 1) {
      where <- paste(where, thisWhere, sep = " AND ")  
    } else {
      where <- paste(where, thisWhere, sep = "")
    }
    
  }
  
  return(where)
}
