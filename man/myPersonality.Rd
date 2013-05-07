\name{myPersonality}
\alias{myPersonality}
\title{Initialize connection to myPersonality database server.}
\usage{
  myPersonality()
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
  examples below).
}
\examples{
# myPersonality()  # Prompts for your user name and password for database connection.
# participants()  # Show information about participants, including available variables.
# participants("age", "gender")  # Retrieve age and gender data for all participants.
# participants("age > 90", "gender")  # Retrieve age and gender data for participants older than 90 years.
}
\keyword{manip}

