#' Locate variables of interest by a text search.
#'
#' This function attempts to locate variables whose name, description, or notes contain a specific sequence of characters.
#' Please note that the search does not pay attention to word boundaries, so search query 'age' would also return 'marriage' as a result.
#' 
#' @param query A character string containing the text to be searched. It is advisable to use queries that are longer than 3 characters.
#' @keywords attribute
#' @export
#' @examples
#' # findVariable("sex")

findVariable <- function(query) {
  sql <- sprintf('SELECT * FROM _meta_variables WHERE name LIKE "%%%s" OR description LIKE "%%%s%%" OR note LIKE "%%%s%%"', query, query, query)
  results <- myPersonalitySQL(sql)
  if (nrow(results) == 0) {
    message("No results.")
    return(invisible(NULL))
  }
  class(results) <- "variable.help"
  return(results)
}
