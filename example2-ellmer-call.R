# This script calls Gemini through ellmer, which handles the API key and request
# for you. It reads the cost-effectiveness results in data/results.csv, fills
# the template in prompts/results_prompt.md, and sends that prompt to the model.
# The reply is plain text describing the results.

# 1. Set up ------------------------------------------------------------------
rm(list = ls())

# Instead, we can call the gemini api with the ellmer package for a simpler interface
library(ellmer)

# 2. Define the inputs -------------------------------------------------------
model <- "gemini-2.5-flash"

url <- paste0(
  "https://generativelanguage.googleapis.com/v1beta/models/",
  model, ":generateContent"
)
system_prompt <- "Respond in English always."

# 3. Create the chat ---------------------------------------------------------
# create a chat, handles the API key and URL automatically
chat <- chat_google_gemini(model = model, system_prompt = system_prompt, params = params(temperature = 0))

# 4. Read in the data --------------------------------------------------------
# create data as text to pass into the chat
csv_text <- paste(readLines("data/results.csv"), collapse = "\n")

# 5. Build the prompt --------------------------------------------------------
# We can then pass data into the chat
prompt <- interpolate_file(
  "prompts/results_prompt.md",
  data = csv_text,
  threshold = "£20,000 to £30,000",
  n_paragraphs = 2,
  table_ref = "Table 1",
  word_limit = 250
)

# 6. Make the API call -------------------------------------------------------
# run the prompt through the chat
results_text <- chat$chat(prompt, echo = "none")
