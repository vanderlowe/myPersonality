generateSQL <- function(x) {
  if (!inherits(x, "virtual.table")) {
    stop("The function requires a 'virtual.table' object.")
  }
  
  if (length(x$where) > 0) {
    where <- generateWHERE(x$where)
  } else {
    where <- ""
  }
  sql.cmd <- sprintf("SELECT %s FROM %s %s", paste(x$table.name, unique(x$columns), sep = ".", collapse = ","), x$table.name, where)
  
  return(sql.cmd)
}

generateWHERE <- function(x) {
  if (!inherits(x, "list")) {
    stop("Input must be a list")
  }
  
  if (length(x) == 0) {return("")}
  
  where <- "WHERE "
  for (i in 1:length(x)) {
    value <- x[i]
    thisWhere <- paste(value)
    if (i > 1) {
      where <- paste(where, thisWhere, sep = " AND ")  
    } else {
      where <- paste(where, thisWhere, sep = "")
    }
    
  }
  
  return(where)
}
