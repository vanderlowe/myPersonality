\name{myPersonalityPackage}
\alias{myPersonalityPackage}
\title{Easy access to myPersonality dataset.}
\description{
  \code{myPersonality} package provides tools that make it
  easy to access data in the large dataset collected and
  maintained by the Cambridge Psychometrics Centre.
}
\section{Register as a collaborator}{
  To gain access to the data, please request access
  privileges by registering as a collaborator. For
  information how to register, please visit
  \url{http://mypersonality.org/wiki/doku.php?id=database_use_guidelines}.
}

\section{Getting started}{
  Once you have your user name and password, start by
  running \code{myPersonality()} function. You will be
  prompted for your user name and password. Once
  successfully connected, you will see a list of functions
  for accessing the data (e.g., \code{participants()}.
  These functions are dynamically created depending on your
  access rights. The data access functions are
  self-documenting: by running one without arguments (e.g.,
  \code{participants()}), the function will print
  additional information about itself.
}

\section{Accessing data}{
  Each data access function allows you to request data from
  the myPersonality database by listing variable names
  available through the function. For example, to retrieve
  age and gender data of all participants in the database,
  you can type \code{participants("age", "gender")}. To
  find out which variables are availabe through each
  function, you can type the function without any
  arguments.

  For more information, please visit
  \url{https://github.com/vanderlowe/myPersonality/blob/master/README.md}.
}
\references{
  Kosinski, M., Stillwell D. J., & Graepel, T. (2013).
  Private traits and attributes are predictable from
  digital records of human behavior. Proceedings of the
  National Academy of Sciences, 110(15), 5802-5805.
}
\seealso{
  \link{myPersonality}, \link{findVariable},
  \link{explainVariable}
}

