% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_exchanges.R
\name{get_exchanges}
\alias{get_exchanges}
\title{Get exchange details}
\usage{
get_exchanges(exchange = NULL)
}
\arguments{
\item{exchange}{A string containing an exchange symbol, e.g. \emph{kraken}. Optional argument.}
}
\value{
data A list or data.frame containing exchange data.
}
\description{
Get information on exchanges.
}
\examples{
\dontrun{
exchange.data <- get_exchanges("kraken")
df.exchanges <- get_exchanges()
}

}
\references{
See \url{https://docs.cryptowat.ch/rest-api} for further information
}
\seealso{
\code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_pairs}}
}