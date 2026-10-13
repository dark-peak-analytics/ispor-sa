build_results_doc <- function(table_out, results_text) {
  read_docx() |>
    body_add_par("Cost-effectiveness results", style = "heading 1") |>
    body_add_par("Table 1: Incremental cost-effectiveness results", style = "table title") |>
    body_add_table(table_out, style = "table_template") |>
    body_add_par("") |>
    body_add_par(results_text, style = "Normal")
}
