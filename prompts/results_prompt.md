Your job is to describe the cost-effectiveness results below
accurately and neutrally.

## Data

The data is a deterministic incremental cost-effectiveness analysis, in CSV
format, between the <data> tags. It is the only source of truth.

<data>
{{data}}
</data>

Column definitions:
- strategy: name of the intervention or comparator.
- total_cost_gbp: mean total cost per patient, in GBP.
- total_qalys: mean total quality-adjusted life years (QALYs) per patient.
- comparator: the strategy that the incremental values are calculated against.
  This is the next less costly non-dominated strategy.
- incremental_cost_gbp: total cost minus the comparator's total cost.
- incremental_qalys: total QALYs minus the comparator's total QALYs.
- icer_gbp_per_qaly: incremental cost-effectiveness ratio, in GBP per QALY gained.
- status: one of
  - "Reference": the least costly strategy, used as the starting point.
  - "Dominated": costs more and produces fewer or equal QALYs than another strategy.
  - "Extendedly dominated": ruled out because a mix of two other strategies
    would give more QALYs at the same cost.
  - "On frontier": on the cost-effectiveness frontier.
- A blank cell means "not applicable". It does not mean zero or missing data.

The willingness-to-pay threshold is {{threshold}} per QALY gained.

## Rules

Accuracy:
1. Use only numbers that appear in the data or in this prompt. Do not
   calculate new figures: no differences, percentages, ratios, net monetary
   benefit or rounded versions of values.
2. Quote values exactly as they appear in the data, formatted as follows:
   costs and ICERs as "£" with thousands separators (e.g. £12,000), and QALYs
   to two decimal places (e.g. 5.60). Never use abbreviations such as "£12k".
3. Always say which comparator an incremental result or ICER is measured
   against.
4. Describe dominated and extendedly dominated strategies using the status
   column. Do not report an ICER for a dominated strategy. If you mention the
   ICER for an extendedly dominated strategy, say it is not used for decisions.
5. If the data does not support a statement, leave the statement out. Do not
   guess, and do not draw on outside knowledge about these treatments.

Interpretation:
6. Compare ICERs on the frontier with the threshold, and say which strategy
   (if any) would be cost-effective at the lower and upper ends of the threshold.
   An ICER exactly at a threshold value should be described as "equal to" it.
7. Do not make recommendations, and do not comment on uncertainty, clinical
   effectiveness or anything else the data does not cover. These results are
   deterministic, so do not mention probabilities or confidence intervals.

Style:
8. Write in the past tense ("Drug Z was associated with..."), in a formal,
   neutral, third-person style. Avoid promotional or evaluative words such as
   "impressive", "excellent" or "clearly superior".
9. Use British English spelling.
10. Write numbers below ten as words (e.g. "five strategies"), except when
    they are data values.
11. Refer to the table as {{table_ref}} at least once.

## Output

Write {{n_paragraphs}} paragraph(s) of continuous prose, at most {{word_limit}}
words in total. Cover, in this order:
1. The strategy with the lowest cost and the one with the most QALYs.
2. Which strategies were dominated or extendedly dominated, and why.
3. The ICERs of the strategies on the frontier, with their comparators.
4. Which strategy would be cost-effective at the stated threshold.

Return a status and a text field. If the data can be described, set status
to "ok" and put only the paragraph text in text: no headings, bullet points,
markdown, preamble or closing remarks. If the data is empty, malformed or
impossible to interpret, set status to "error" and put a short reason in text.
