# 1. Set up ------------------------------------------------------------------
rm(list = ls())
# install.packages("httr2")
library(httr2)

# 2. Define the inputs -------------------------------------------------------
# The API key should be in the system environment variable stored in .Renviron.
# It is important not to put keys in the codebase pushed to GitHub
api_key <- Sys.getenv("GEMINI_API_KEY")
if (api_key == "") stop("Set GEMINI_API_KEY in .Renviron")

model <- "gemini-2.5-flash"
url <- paste0(
  "https://generativelanguage.googleapis.com/v1beta/models/",
  model, ":generateContent"
)
# The temperature of 0 gives the most predictable output, and higher values give more varied output.
temperature <- 0

# 3. Write a function that makes one API call --------------------------------
# Send one prompt to Gemini and return the text of the reply
# Note that in the next script this bit is simplified.
ask_gemini <- function(prompt) {
  resp <- request(url) |>
    req_headers("x-goog-api-key" = api_key) |>
    req_body_json(list(
      contents = list(list(parts = list(list(text = prompt)))),
      generationConfig = list(temperature = temperature)
    )) |>
    # retry on rate limits (429) and temporary outages (503)
    req_retry(max_tries = 5) |>
    req_perform()

  result <- resp_body_json(resp)
  result$candidates[[1]]$content$parts[[1]]$text %||% NA_character_
}

# 4. Write a function that builds the prompt ---------------------------------
letter_prompt <- function(letter) {
  paste0(
    "Tell me something interesting about the letter '", letter, "'. ",
    "Respond with one sentence."
  )
}

# 5. Make one API call -------------------------------------------------------
# Make the API call with the letter A
cat(ask_gemini(prompt = letter_prompt(letter = "A")))

# 6. Repeat the call for many prompts ----------------------------------------
# Now, repeat the call for each letter in the alphabet
# Note that this sends 26 seperate requests to the API
letter_facts <- lapply(letters, function(letter) {
  ask_gemini(letter_prompt(letter))
})
names(letter_facts) <- letters

# 7. Look at the results -----------------------------------------------------
# Pick out any letter by name to access the output data
letter_facts$u
