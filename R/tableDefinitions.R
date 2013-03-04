participants <- function(...) {
  mySQL.table.name <- "demog"
  return(createVirtualTable(mySQL.table.name, ...))
}

address <- function(...) {
  mySQL.table.name <- "address"
  return(createVirtualTable(mySQL.table.name, ...))
}

employers <- function(...) {
  mySQL.table.name <- "fb_employer"
  return(createVirtualTable(mySQL.table.name, ...))
}
