\name{explainVariable}
\alias{explainVariable}
\title{Provide information about specific myPersonality variable.}
\usage{
  explainVariable(variable.name)
}
\arguments{
  \item{variable.name}{A character string that specifies
  the variable of interest.}
}
\description{
  This function describes the speficied variable by
  fetching additional metainformation about it from the
  myPersonality database. If a variable exists in multiple
  tables, the function asks the user to specify which
  table/variable pair to show.
}
\examples{
# explainVariable("gender")
# explainVariable("userid")  # Multiple tables contain variable 'userid'
}
\keyword{attribute}

