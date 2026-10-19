fmt_num <- function(x, digits = 0) {
  ifelse(is.na(x), "", formatC(x, format = "f", digits = digits, big.mark = ","))
}
