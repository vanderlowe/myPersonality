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
\description{
  This function executes SQL queries on the Cambridge
  Psychometrics Centre database. \code{myPersonalitySQL}
  automatically uses the right R package for database
  access, depending on your operating system (RMySQL for
  Mac and RODBC for Windows).
}
\examples{
#myPersonality()
#myPersonality("SELECT * FROM demog")
}
\keyword{manip}

