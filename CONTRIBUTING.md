# Contributing

Thanks for helping make Rightsize more accurate.

## Most valuable contributions

1. **Benchmark results.** Run tasks from `benchmark/tasks.csv` (or your own, anonymised) on the predicted setting and its neighbours, following `benchmark/README.md`, and open a PR with your results.
2. **Rubric corrections backed by results.** If a task type is consistently over- or under-predicted, propose a change with the evidence.
3. **Model updates.** When Anthropic releases or retires a model, update `references/models.md` with a link to the source and the date you checked.

## Guidelines

- Keep `SKILL.md` short; detail belongs in `references/`.
- Cite Anthropic's documentation for any claim about model capabilities or defaults.
- Never commit confidential data in benchmark tasks.
- Bump `version` in both `plugin.json` and `marketplace.json` on release.

## Releasing

1. Bump the version in `plugins/rightsize/.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`, and push the change.
2. On GitHub, create a release tagged with the same version with a `v` in front (for example `v0.1.2`), and publish it.

That's all. A GitHub Action (`.github/workflows/release-skill.yml`) then checks that the tag matches both version fields, builds `rightsize-skill.zip` from the skill folder, and attaches it to the release. It takes about a minute; check the repository's **Actions** tab if the ZIP doesn't appear.

If the Action reports a version mismatch, fix the version fields, then delete and recreate the release.

To build the ZIP by hand instead, run this from the repository root:

```
cd plugins/rightsize/skills && zip -r ../../../rightsize-skill.zip rightsize && cd -
```
