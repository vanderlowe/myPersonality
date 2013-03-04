.forbidden.symbols <- c(" ", "!", "<", ">", "(", ")", "?")

isWHERE <- function(x) {  
  x.chars <- strsplit(x, "")[[1]]
  if (any(.forbidden.symbols %in% x.chars)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

extractColumn <- function(x) {
  if (length(x) > 1) {
    stop("This function is not vectorized. You must supply only one string at a time.")
  }
  for (thisSymbol in .forbidden.symbols) {
    s <- strsplit(x, thisSymbol, fixed = TRUE)[[1]]
    if (length(s) > 1) {return(s[1])}
  }
  names(x) <- NULL
  return(x)
}

getFunctionArguments <- function(...) {
  args <- list(...)
  results <- unlist(args)
  names(results) <- NULL
  return(results)
}

processFunctionArguments <- function(...) {
  args <- getFunctionArguments(...)
  if (is.null(args)) {return(NULL)}
  
  results <- list()
  results$columns <- unlist(lapply(args, extractColumn))
  
  wheres <- args[sapply(args, isWHERE)]
  if (!identical(wheres, character(0))) {
    results$where <- wheres
  } else {
    results$where <- NULL
  }
  # Check if no WHERE argements were provided

  return(results)
}
