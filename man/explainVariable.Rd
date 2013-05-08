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
\dontrun{
explainVariable("gender")
}
# Multiple tables contain variable 'userid'.
# Read instructions in the function output to select the right table.
\dontrun{
explainVariable("userid")
}
}
\seealso{
  \link{findVariable}
}
\keyword{attribute}

