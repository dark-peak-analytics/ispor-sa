# ISPOR South Africa: generative AI short course

Materials for a short course on generative AI in health economics, prepared for ISPOR South Africa.

The repository contains three R scripts that build on each other:

1. `example1-httr2.R` calls the Gemini API directly with httr2.
2. `example2-ellmer-call.R` makes the same kind of call through ellmer, filling a prompt template from a small cost-effectiveness results table.
3. `example3-ellmer-report.R` asks for a structured reply and writes a short Word report with officer.

Prompts are in `prompts/`, the example data is in `data/`, and small helper functions are in `R/`.

## How to run

Use R 4.1 or later, and set the working directory to the root of this repository before sourcing a script. The scripts read `data/` and `prompts/` with relative paths.

Install the packages the scripts load:

```r
install.packages(c("httr2", "ellmer", "officer"))
```

`example1-httr2.R` needs `httr2`. `example2-ellmer-call.R` needs `ellmer`. `example3-ellmer-report.R` needs `ellmer` and `officer`.

Create a Gemini API key in [Google AI Studio](https://aistudio.google.com/apikey), then put it in a file named `.Renviron` in this folder:

```
GEMINI_API_KEY=your-key-here
```

`.Renviron` is listed in `.gitignore`, so the key stays off GitHub. Restart R after saving the file so the variable is picked up. In a new session you can check it with `Sys.getenv("GEMINI_API_KEY")`. `example1-httr2.R` reads that variable itself. The ellmer scripts pass it to Gemini through `chat_google_gemini()`.

From the project root, run one script at a time:

```r
source("example1-httr2.R")
source("example2-ellmer-call.R")
source("example3-ellmer-report.R")
```

`example1-httr2.R` sends 27 requests: one for the letter A, then one for each letter of the alphabet. `example2-ellmer-call.R` leaves the drafted paragraph in `results_text`. `example3-ellmer-report.R` writes `results-report.docx` in the project root and opens it.

## Disclaimer

This is a simple teaching example. The scripts show how to call a large language model via an API and draft a results paragraph from a small deterministic cost-effectiveness table. They are classroom demonstrations. Check every number and sentence before model output is used in any real piece of work.

## Authors

Dr Robert Smith is the lead author of these materials. He is a health economist and Managing Director of [Dark Peak Analytics](https://darkpeakanalytics.com/). His work applies methods from data science to health economics, including script-based decision models, web interfaces that make those models easier to inspect, and training in R.

Dr Carina Behr is an author of these materials. She is a Senior Health Economist at [Dark Peak Analytics](https://darkpeakanalytics.com/). Her work covers health-economic evaluation, including cost-effectiveness and microsimulation models in R, and training.

[Dark Peak Analytics](https://darkpeakanalytics.com/) is a UK consultancy working at the intersection of health economics, data science, and public health. It builds health-economic models in R, including web-based interfaces, and runs training on R and Shiny for health economics and related fields.
