# Model reference

Last verified: 2026-10-09. Models change often; check the sources below and update this file before each release.

| Model | API ID | Claude Code alias | Default effort | Best suited to |
|---|---|---|---|---|
| Claude Haiku 5.5 | claude-haiku-5-5 | haiku | medium | Lowest latency and price: real-time and high-volume work, sub-agent tasks |
| Claude Sonnet 5.5 | claude-sonnet-5-5 | sonnet | high | Everyday coding, data analysis, content creation, agentic tool use |
| Claude Opus 5.5 | claude-opus-5-5 | opus | medium | Complex agentic coding and enterprise work, large refactors, long-running knowledge work |
| Claude Fable 5.1 | claude-fable-5-1 | fable | high | The highest available capability: hours-long agent sessions, deep research carried through to finished deliverables |

Not generally available: Claude Mythos 5.1 (same capabilities as Fable 5.1, restricted to verified organizations). Do not recommend it unless the user says they have access.

## Effort levels

`low`, `medium`, `high`, `xhigh`, `max`. All four models above support all five. Setting effort to a model's default is the same as leaving it unset.

## How to set model and effort

- **Claude.ai**: choose the model in the model picker.
- **Claude Code**: `/model <alias>` and `/effort <level>`; subagent files accept `model:` and `effort:` in their frontmatter.
- **API**: `model` on the request, and `output_config: {"effort": "<level>"}`.

## Sources

- Choosing a model: https://platform.claude.com/docs/en/about-claude/models/choosing-a-model
- Effort: https://platform.claude.com/docs/en/build-with-claude/effort
- Models and pricing: https://platform.claude.com/docs/en/models/overview
- Claude Code subagents: https://code.claude.com/docs/en/sub-agents
