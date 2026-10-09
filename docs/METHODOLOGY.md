# Methodology

## What the labels mean

Labels are written by hand by the maintainer, from the point of view of a service that calls the API. They are not the output of any tool. Where a spec-level diff tool and the consumer view disagree, the case keeps the consumer-view label and says so in `note`. Two such cases exist today (02 and 12): oasdiff reports them as info-level changes, and they still break the consumers listed.

## Current cases are synthetic

All 13 current cases use one small invented "Orders API" and a hand-made mutation per case. They test whether a tool recognises each kind of change. They say nothing about how a tool performs on real-world specs. Real-project cases are planned and will be marked `labelled_by: real project`.

## Scoring

`scripts/run.sh` scores breaking yes/no per case against `expected.breaking` and prints caught, missed, false alarms and correct negatives. Affected-consumer scoring is not automated yet.

## Reference run

Tool: oasdiff v1.33.0 (`go install github.com/oasdiff/oasdiff@latest`, built 2026-10-09), command `oasdiff breaking --fail-on ERR`.
Result on the 13 cases: 8 caught, 2 missed (cases 02 and 12), 0 false alarms, 3 correct negatives. Re-run it yourself with `scripts/run.sh`. A different oasdiff version or flags (for example `--fail-on INFO`) will change the numbers.

## Limits

- 13 small synthetic cases is a regression suite, not a benchmark of real-world accuracy.
- The maintainer wrote both the cases and the labels. Disputed labels are welcome as issues.
- This repo has not been run against Impact Gate or any other tool besides oasdiff.
