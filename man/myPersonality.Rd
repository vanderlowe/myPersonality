\name{myPersonality}
\alias{myPersonality}
\title{Retrieve data from the myPersonality database server.}
\usage{
  myPersonality()
}
\arguments{
  \item{query}{A character string that specifies the
  variables that you are interested in. If left blank, it
  will show the available options.}
}
\description{
  This function retrieves data from the Cambridge
  Psychometrics Centre's myPersonality database.
}
\examples{
#participants()
#participants("age > 90")
}
\keyword{manip}

