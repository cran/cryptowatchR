#' Get prices of cryptocurrencies
#'
#' Get data.frame with prices of cryptocurrencies using the REST API of cryptowat.ch. The route is \emph{ohlc} and returns OHLC candlestick prices. The default is daily prices but can be changed with \code{periods}. See \url{https://docs.cryptowat.ch/rest-api/markets/ohlc} for further information.
#'
#' @usage get_ohlc(pair, before = NULL, after = NULL, periods = NULL, exchange = "kraken",
#'          datetime = TRUE, api_key = NULL, allowance = FALSE)
#' @param pair A character string containing a pair symbol, e.g. \emph{btcusd} (required argument). Run \code{get_pairs()} to find other available pairs.
#' @param before An integer if \emph{datetime} is \code{FALSE} and a character string if it is \code{TRUE}: Only returns candles opening before this time (optional).
#' @param after An integer if \emph{datetime} is \code{FALSE} and a character string if it is \code{TRUE}: Only returns candles opening after this time (optional).
#' @param periods A integer or integer vector. Only return these periods. Periods are measured in seconds (optional). Examples: 60, 180, 108000.
#' @param exchange A character string containing the exchange. Default is \emph{kraken}. Run \code{get_exchanges()} to find other available exchanges.
#' @param datetime A logical. \code{TRUE} indicates that datetime type is used. \code{FALSE} indicates \emph{unix timestamp}. Default is \code{TRUE}.
#' @param api_key A character string containing the API key. See \url{https://docs.cryptowat.ch/rest-api/rate-limit} to learn how to create an account and how to generate an API key.
#' @param allowance A logical (default is \code{FALSE}). If \code{TRUE} the function returns a list which includes allowance information, i.e. cost of the request, remaining credits and your account name.
#'
#' @return A data.frame containing OHLC candlestick prices of a given pair of currencies. If allowance is \code{TRUE}, \code{get_ohlc()} returns a list.
#'
#' @references See \url{https://docs.cryptowat.ch/rest-api} for further information.
#' @seealso \code{\link{get_markets}}, \code{\link{get_assets}}, \code{\link{get_exchanges}}, \code{\link{get_pairs}}
#' @examples
#' \dontrun{
#' # Daily prices of Bitcoin in USD
#' df.ohlc <- get_ohlc("btcusd")
#' # Hourly prices of Bitcoin in USD for a specific time period
#' df.ohlc.hourly <- get_ohlc("btcusd", periods = 3600, before = 1609851600,
#'                                           after = 1609506000, datetime = FALSE)
#' # Daily prices of Bitcoin in Euro for a specific time period
#' df.ohlc.daily <- get_ohlc("btceur", periods = 86400, before = "2021-05-12",
#'                                           after = "2021-01-01", datetime = TRUE)
#' }
#'
#' @export
get_ohlc <- function(pair, before = NULL, after = NULL, periods = NULL, exchange = "kraken",
                     datetime = TRUE, api_key = NULL, allowance = FALSE) {

  if (datetime) {

    if ( !is.null(before) ) before <- as.numeric(as.POSIXct(before))
    if ( !is.null(after) ) after <- as.numeric(as.POSIXct(after))

  }

  params <- list(before = before, after = after, periods = periods)

  prices <- get_markets(route = "ohlc", pair, exchange, params, api_key, allowance)

  if (allowance) {

    if ( !is.null(params[["periods"]]) ) {

      df.prices <- data.frame(prices[[1]][[1]])

    } else if ( is.null(params[["periods"]]) ) {

      df.prices <- data.frame(prices[[1]][names(prices) == "86400"])

    }

    allowance.list <- prices[[2]]

  } else if (allowance == FALSE) {

    if ( !is.null(params[["periods"]]) ) {

      df.prices <- data.frame(prices[[1]])

    } else if ( is.null(params[["periods"]]) ) {

      df.prices <- data.frame(prices[names(prices) == "86400"])

    }

  }

  names(df.prices) <- c("CloseTime", "OpenPrice", "HighPrice", "LowPrice", "ClosePrice", "Volume", "QuoteVolume")

  if (datetime) df.prices$CloseTime <- lubridate::as_datetime(df.prices$CloseTime)


  if (allowance) {

    output <- list(result = df.prices, allowance = allowance.list)

  } else if (allowance == FALSE) {

    output <- df.prices

  }

  return(output)

}
