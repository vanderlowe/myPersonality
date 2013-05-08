\name{print.variable.help}
\alias{print.variable.help}
\title{Prints myPersonality variable information.}
\usage{
  \method{print}{variable.help} (x)
}
\arguments{
  \item{x}{An object returned by either findVariable or
  explainVariable functions}
}
\description{
  This function extends generic print function.
}
\examples{
# explainVariable("gender")
# explainVariable("userid")  # Multiple tables contain variable 'userid'
}
\keyword{attribute}

