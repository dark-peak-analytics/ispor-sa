# ISPOR South Africa: generative AI short course

Materials for a short course on generative AI in health economics, prepared for ISPOR South Africa.

The repository contains three R scripts that build on each other:

1. `example1-httr2.R` calls the Gemini API directly with httr2.
2. `example2-ellmer-call.R` makes the same kind of call through ellmer, filling a prompt template from a small cost-effectiveness results table.
3. `example3-ellmer-report.R` asks for a structured reply and writes a short Word report with officer.

Prompts are in `prompts/`, the example data is in `data/`, and small helper functions are in `R/`. The scripts expect a `GEMINI_API_KEY` environment variable (for example in `.Renviron`).

## Disclaimer

This is a simple teaching example. The scripts show how to call a language model and draft a results paragraph from a small deterministic cost-effectiveness table. They are classroom demonstrations. Check every number and sentence before model output is used in any real piece of work.

## Lead author

Dr Robert Smith is the lead author of these materials. He is a health economist and Managing Director of [Dark Peak Analytics](https://darkpeakanalytics.com/). His work applies methods from data science to health economics, including script-based decision models, web interfaces that make those models easier to inspect, and training in R.

[Dark Peak Analytics](https://darkpeakanalytics.com/) is a UK consultancy working at the intersection of health economics, data science, and public health. It builds health-economic models in R, including web-based interfaces, and runs training on R and Shiny for health economics and related fields.
