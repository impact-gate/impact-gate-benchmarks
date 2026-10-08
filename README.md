# impact-gate-benchmarks

Reproducible benchmark cases for OpenAPI breaking-change detection and consumer-impact analysis. Maintained alongside [Impact Gate](https://impactgate.in), a warn-only pull request gate that reports which consumers an API contract change can affect.

**Status: early. No published results yet.** This repository currently defines the structure and rules for cases. Cases and numbers are added only once they can be reproduced from this repo.

## What a case is

A case is a small, self-contained scenario:

- a provider OpenAPI spec before and after a change (`before.yaml`, `after.yaml`)
- one or more consumer code samples that call the provider
- a hand-written `expected.json` stating which consumer call sites are affected, and why

## Planned layout

```
cases/
  <case-id>/
    before.yaml
    after.yaml
    consumers/
    expected.json
    NOTES.md        # why the case exists, how expected.json was derived
docs/
  CASE_FORMAT.md    # schema for expected.json
  METHODOLOGY.md    # scoring: precision, recall, false-positive handling
scripts/
  run.sh            # run a tool against every case and print a comparison
```

## How to run

Not available yet. `scripts/run.sh` will be added with the first cases. Any tool that can read two OpenAPI specs and a consumer directory can be scored, not only Impact Gate.

## Limits

- Cases are small and hand-labelled, so they say little about large real-world estates.
- Expected results are written by the maintainer and can be wrong. Please open an issue with a counter-example.
- No result here should be read as a claim about production accuracy.

## Contributing

Issues with disputed labels or new case proposals are welcome. Every case must include its derivation in `NOTES.md`.

## License

MIT, see [LICENSE](LICENSE).
