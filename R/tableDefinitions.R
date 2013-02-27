participants <- function(variables, ...) {
  mySQL.table.name <- "demog"
  
  return(createVirtualTable(mySQL.table.name, variables, ...))
}

address <- function(variables, ...) {
  mySQL.table.name <- "address"
  return(createVirtualTable(mySQL.table.name, variables, ...))
}

employers <- function(variables, ...) {
  mySQL.table.name <- "fb_employer"
  return(createVirtualTable(mySQL.table.name, variables, ...))
}
