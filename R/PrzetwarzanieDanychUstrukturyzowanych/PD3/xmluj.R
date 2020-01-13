xmluj <- function(x) {
  require(XML)
  require(data.table)
  
  y <- xmlParse(x)
  y <- xmlToList(y)
  y <- lapply(y, function(x) as.data.table(as.list(x)))
  rbindlist(y, use.names=T, fill=T)
}