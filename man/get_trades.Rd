% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_trades.R
\name{get_trades}
\alias{get_trades}
\title{Get trades of cryptocurrencies}
\usage{
get_trades(pair, since = NULL, limit = NULL, exchange = "kraken",
           datetime = TRUE, api_key = NULL, allowance = FALSE)
}
\arguments{
\item{pair}{A character string containing a pair symbol, e.g. \emph{btcusd} (required argument). Run \code{get_pairs()} to find other available pairs.}

\item{since}{An integer if \emph{datetime} is \code{FALSE} and a character string if it is \code{TRUE}: Limit the response to trades after this date (optional). This can only be used to filter recent trades. Historical trades cannot be retrieved.}

\item{limit}{An integer: Limit the number of trades (optional). Max: 1000.}

\item{exchange}{A character string containing the exchange. Default is \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.}

\item{datetime}{A logical. \code{TRUE} indicates that datetime type is used. \code{FALSE} indicates \emph{unix timestamp}. Default is \code{TRUE}.}

\item{api_key}{A character string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.}

\item{allowance}{A logical (default is \code{FALSE}). If \code{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.}
}
\value{
A data.frame containing trades of a given pair of currencies. If allowance is \code{TRUE}, \code{get_trades()} returns a list.
}
\description{
Get data.frame with trades of cryptocurrencies using the REST API of cryptowat.ch. The route is \emph{trades} and returns trades for a specified market. See \url{https://docs.cryptowat.ch/rest-api/markets/trades} for further information.
}
\examples{
\dontrun{
# Most recent trades (default is 50)
trades <- get_trades(pair)
# 200 trades (maximum is 1000) since 1589571417 (unix timestamp)
trades.unix <- get_trades(pair, since = 1589571417, limit = 200, datetime = FALSE)
# 1000 trades and datetime is TRUE
trades.datetime <- get_trades(pair, since = "2021-06-01", limit = 1000)
}

}
\references{
See \url{https://docs.cryptowat.ch/rest-api} for further information.
}
\seealso{
\code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
}
