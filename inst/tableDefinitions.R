# This script creates functions to access data based on the tables in the database.
# Please note that the table names must be matched to display names in _meta_tables table.

all.tables <- myPersonalitySQL("SHOW TABLES")[,1]
.meta.tables <- myPersonalitySQL("SELECT * FROM _meta_tables")
.meta.tables <- as.data.frame(.meta.tables, stringsAsFactors = F)

for (this.table in all.tables) {
  if (substring(this.table, 1, 1) == "_") {next}  # Skip meta tables
  
  # Create functions from database tables
  function.template <- "%s <- function(...) { mySQL.table.name <- '%s'
    return(myPersonality:::createVirtualTable(mySQL.table.name, ...))
  }"
  
  sql <- sprintf('SELECT display_name FROM `_meta_tables` WHERE db_name = "%s"', this.table)
  
  display.name <- myPersonalitySQL(sql)
  if (nrow(display.name) == 0) {
    # There was no suitable display name in _meta_tables.
    next  
  } else {
    display.name <- display.name[, 1]
  }
  
  eval(parse(text = sprintf(function.template, display.name, this.table)))
}
rm(all.tables, this.table, display.name, function.template, sql)