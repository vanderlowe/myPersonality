\name{myPersonalitySQL}
\alias{myPersonalitySQL}
\title{Execute SQL query on myPersonality database server.}
\usage{
  myPersonalitySQL(query = "SHOW TABLES;", user = NULL,
    password = NULL)
}
\arguments{
  \item{query}{SQL query string to be executed. Defaults to
  "SHOW TABLES;"}
}
\value{
  A \code{data.table} object.
}
\description{
  This function executes SQL queries on the Cambridge
  Psychometrics Centre database. It is meant for advanced
  users only. By default, users only have privileges for
  queries using SELECT statements.
}
\note{
  The query must be enclosed in \bold{single} quotation
  marks.
}
\examples{
\dontrun{
myPersonalitySQL("SELECT * FROM demog")
}
}
\keyword{manip}

