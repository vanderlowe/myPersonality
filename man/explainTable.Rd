\name{explainTable}
\alias{explainTable}
\title{Information about myPersonality database tables.}
\usage{
  explainTable(table.name)
}
\arguments{
  \item{table.name}{A character string that specifies the
  table that you are interested in.}
}
\description{
  This function retrieves metadata about tables from the
  Cambridge Psychometrics Centre's myPersonality database.
  However, it is easier to run the data access function
  without an argument to get the same results (e.g.,
  \code{participants()}).
}
\examples{
\dontrun{
explainTable("address")
}
}
\seealso{
  \link{myPersonality}, \link{explainVariable}
}
\keyword{attribute}

