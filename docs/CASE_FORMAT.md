# Case format

Each case is a directory under `cases/`:

```
cases/<nn>-<slug>/
  before.yaml   OpenAPI 3.0 spec before the change
  after.yaml    OpenAPI 3.0 spec after the change
  case.json     label and consumers
```

`case.json` fields:

- `id`, `title`, `note`: human description.
- `labelled_by`: who labelled it and whether the specs are synthetic or from a real project.
- `expected.breaking`: true if the change breaks at least one realistic consumer of the API or violates the API contract. This is the label a tool is scored on.
- `expected.changes`: the changes a reviewer should see (operation and kind). Informational for now.
- `expected.affected_consumers`: names from `consumers` that stop working. Empty means no listed consumer is affected.
- `consumers`: small descriptions of services that call the API. Each lists the operations it uses, which fields it reads or sends, and whether it decodes responses strictly (closed enums, exact types).

A consumer is affected when a change touches an operation it calls and a field, parameter or behavior it depends on.
