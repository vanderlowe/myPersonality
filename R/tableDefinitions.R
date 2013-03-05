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

satisfaction_with_life <- function(...) {
  mySQL.table.name <- "swl"
  return(createVirtualTable(mySQL.table.name, ...))
}

facebook_likes <- function(...) {
  mySQL.table.name <- "fb_like"
  return(createVirtualTable(mySQL.table.name, ...))
}

participant_likes <- function(...) {
  mySQL.table.name <- "fb_user_like"
  return(createVirtualTable(mySQL.table.name, ...))
}