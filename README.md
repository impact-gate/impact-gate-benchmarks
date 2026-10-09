# impact-gate-benchmarks

Labelled before/after OpenAPI cases for testing breaking-change detection and consumer-impact analysis. Maintained alongside [Impact Gate](https://impactgate.in), a warn-only pull request gate that reports which consumers an API contract change can affect.

**Status: early.** 13 small synthetic cases, one runnable scorer, one reference run (oasdiff). No real-project cases yet and no Impact Gate results published here.

## What is in the repo

- `cases/` - 13 cases on one invented "Orders API": 10 breaking changes (one with no affected consumer), 3 non-breaking controls.
- `docs/CASE_FORMAT.md` - what each file in a case means.
- `docs/METHODOLOGY.md` - how labels are made, scoring, the reference run and its limits.
- `scripts/run.sh` - runs a diff tool over every case and scores breaking yes/no.

## How to run

You need Python 3 and [oasdiff](https://github.com/oasdiff/oasdiff).

```
go install github.com/oasdiff/oasdiff@latest
git clone https://github.com/impact-gate/impact-gate-benchmarks
cd impact-gate-benchmarks
bash scripts/run.sh
```

To score another tool, set `TOOL_CMD` to a command that takes `BEFORE AFTER` spec paths and exits non-zero when it reports a breaking change:

```
TOOL_CMD="my-diff-tool --check" bash scripts/run.sh
```

Reference result with oasdiff v1.33.0 (`oasdiff breaking --fail-on ERR`): 8 caught, 2 missed, 0 false alarms, 3 correct negatives. The two misses (cases 02 and 12) are changes oasdiff reports at info level that still break the listed consumers. See `docs/METHODOLOGY.md`.

## Limits

- All cases are synthetic and share one small API. This is a regression suite, not a measure of real-world accuracy.
- The maintainer wrote both the cases and the labels, and can be wrong. Open an issue with a counter-example.
- Scoring covers breaking yes/no only. Affected-consumer scoring is not automated yet.

## Contributing

Disputed labels and new case proposals are welcome as issues. Each case needs `before.yaml`, `after.yaml` and `case.json` as described in `docs/CASE_FORMAT.md`.

## License

MIT, see [LICENSE](LICENSE).
