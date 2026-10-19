# This script writes a short Word report from the cost-effectiveness results.
# It uses ellmer to ask Gemini for a structured reply (a status and a paragraph),
# and stops if the model cannot interpret the data. It then formats the CSV as
# a table and, with officer, saves results-report.docx and opens it.

# 1. Set up ------------------------------------------------------------------
# Install the packages if they are not already installed
# install.packages("officer")
# install.packages("ellmer")

rm(list = ls())

library(ellmer)
library(officer)

# Source R code
source("R/fmt_num.R")
source("R/format_results_table.R")
source("R/build_results_doc.R")

# 2. Load the prompts, data and settings -------------------------------------
# load prompt files
system_prompt <- paste(readLines("prompts/ellmer-with-report-system-prompt.md"), collapse = " ")

# Read in the data and set parameters
data_file <- "data/results.csv"
csv_text <- paste(readLines(data_file), collapse = "\n")
temperature <- 0
model <- "gemini-2.5-flash"

# 3. Create the chat ---------------------------------------------------------
# Create the chat object, handling the API key and URL automatically
# We don't need to pass the API key and URL explicitly here because the chat_google_gemini function handles that.
# It looks for the API key in the GEMINI_API_KEY environment variable.
chat <- chat_google_gemini(
  model = model,
  system_prompt = system_prompt,
  params = params(temperature = temperature)
)

# 4. Build the prompt --------------------------------------------------------
# Create the prompt for the API call from the template and data
prompt <- interpolate_file(
  "prompts/results_prompt.md",
  data = csv_text,
  threshold = "£20,000 to £30,000",
  table_ref = "Table 1",
  n_paragraphs = 1,
  word_limit = 200
)

# 5. Define the shape of the reply -------------------------------------------
# Define the structure of the response we want back from the model
result_type <- type_object(
  status = type_enum(
    values = c("ok", "error"),
    description = "'error' if the data is empty, malformed or impossible to interpret"
  ),
  text = type_string(
    description = "The results paragraph(s), or a short reason if status is 'error'"
  )
)

# 6. Make the API call -------------------------------------------------------
# Generate the results text, triggering the API call (which stops on HTTP errors)
# and stop if the model reports that it could not interpret the data
result <- chat$chat_structured(prompt, type = result_type, echo = "none")
if (result$status != "ok") stop("Model could not write results: ", result$text)
results_text <- result$text

# 7. Build the results table -------------------------------------------------
# Format the table for display
results <- read.csv(data_file)

# Create the table data frame
table_out <- format_results_table(results)

# 8. Create and save the Word report -----------------------------------------
# Create the report using officer
doc <- build_results_doc(table_out, results_text)

# Save the report to a file
print(doc, target = "results-report.docx")

# Open the report in the default viewer
shell.exec(normalizePath("results-report.docx"))
