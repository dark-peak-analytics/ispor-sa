format_results_table <- function(results) {
  data.frame(
    "Strategy"             = results$strategy,
    "Total cost (£)"       = fmt_num(results$total_cost_gbp),
    "Total QALYs"          = fmt_num(results$total_qalys, 2),
    "Comparator"           = results$comparator,
    "Incremental cost (£)" = fmt_num(results$incremental_cost_gbp),
    "Incremental QALYs"    = fmt_num(results$incremental_qalys, 2),
    "ICER (£/QALY)"        = fmt_num(results$icer_gbp_per_qaly),
    "Status"               = results$status,
    check.names = FALSE
  )
}
