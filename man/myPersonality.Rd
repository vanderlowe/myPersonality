\name{myPersonality}
\alias{myPersonality}
\title{Initialize connection to myPersonality database server.}
\usage{
  myPersonality(user = NULL, password = NULL)
}
\arguments{
  \item{user}{Your user name (as provided by the Cambridge
  Psychometrics Centre).}

  \item{password}{Your password (as provided by the
  Cambridge Psychometrics Centre)}
}
\value{
  A printout of data access functions.
}
\description{
  This function starts your session and sets up your
  connection to the Cambridge Psychometrics Centre's
  myPersonality database. Running this function and
  providing valid user name and password when prompted sets
  up other data access functions, such as
  \code{participants()}. The exact names and number of the
  data access functions depends on your access privileges.
}
\details{
  Once the other data access functions have been set up,
  you can use them to retrieve and filter data (see
  examples below). For more instructions, please visit
  \url{https://github.com/vanderlowe/myPersonality/blob/master/README.md}.
}
\note{
  You must contact the Cambridge Psychometrics Centre to
  obtain access privileges. \bold{You cannot use this
  package without a valid user name and password.} If you
  do not have one, please visit
  \url{http://mypersonality.org/wiki/doku.php?id=database_use_guidelines}
  to register as a collaborator.
}
\examples{
# Establish database connection and generate data access functions.
\dontrun{
myPersonality()
}
# Show information about participants, including available variables.
\dontrun{
participants()
}
# Retrieve age and gender data for all participants.
\dontrun{
participants("age", "gender")
}
# Retrieve age and gender data for participants older than 90 years.
\dontrun{
participants("age > 90", "gender")
}
}
\seealso{
  \link{myPersonalityPackage}, \link{findVariable}
}
\keyword{manip}

