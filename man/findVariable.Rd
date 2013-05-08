\name{findVariable}
\alias{findVariable}
\title{Locate variables of interest by a text search.}
\usage{
  findVariable(query)
}
\arguments{
  \item{query}{A character string containing the text to be
  searched. It is advisable to use queries that are longer
  than 3 characters.}
}
\description{
  This function attempts to locate variables whose name,
  description, or notes contain a specific sequence of
  characters. Please note that the search does not pay
  attention to word boundaries, so search query 'age' would
  also return 'marriage' as a result.
}
\examples{
\dontrun{
findVariable("sex")
}
}
\seealso{
  \link{explainVariable}
}
\keyword{attribute}

