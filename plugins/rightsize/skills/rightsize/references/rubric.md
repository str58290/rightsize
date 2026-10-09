# Rightsize rubric (v0.1)

Status: seeded from Anthropic's model-selection and effort documentation (checked 2026-10-09). Not yet validated by the project benchmark. Contributions with measured results are welcome.

## Step 1: score five dimensions (0 to 2 each)

| Dimension | 0 | 1 | 2 |
|---|---|---|---|
| Reasoning depth | Lookup, reformat, extract, translate, classify | Some judgment or synthesis; standard coding or writing | Multi-step reasoning, novel problems, debugging unknown causes, architecture |
| Context load | A short input or one small file | A few documents or files | A large codebase, many sources, or a long document that must be reasoned over as a whole |
| Stakes | Private, throwaway, easy to check | Shared with colleagues; mistakes are annoying | Client-facing, production code, legal, financial or medical consequences; hard to check |
| Ambiguity | Clear spec with a single right answer | Some interpretation needed | Open-ended, conflicting information, or the user is unsure what they want |
| Horizon | A single reply | A few tool calls or steps | A long agentic run (roughly 30 minutes or more, many tool calls) |

Add the scores for a total from 0 to 10.

## Step 2: map the total to a starting point

| Total | Model | Effort |
|---|---|---|
| 0 to 2 | Haiku 5.5 | low |
| 3 to 4 | Sonnet 5.5 (Haiku 5.5 at medium is worth testing for routine, repeated tasks) | low, or medium for anything others will read or run |
| 5 to 6 | Sonnet 5.5 | medium (high if reasoning depth is 2) |
| 7 to 8 | Opus 5.5 | high |
| 9 to 10 | Opus 5.5 at xhigh, or Fable 5.1 at high | high to xhigh |

## Step 3: apply overrides

These take priority over the table.

1. **Stakes = 2** means at least Sonnet 5.5 at high effort, whatever the total.
2. **Horizon = 2** means at least high effort. Use xhigh for long-running agentic or coding work, which Anthropic describes as the level for tasks over about 30 minutes.
3. **Context-heavy but simple** (context load 2, reasoning depth 0): stay on Sonnet 5.5 at medium. Reading a lot is not the same as thinking hard.
4. **Unsure or on a boundary**: go one step up (either a higher effort or the next model). A redo costs more than the difference.
5. **Already failed once** on a setting with good context: step up the model, not just the effort. Anthropic's guidance is that if Claude had the relevant context, clearly tried, and still got it wrong, that signals a more capable model is needed.
6. **max effort** only when the user explicitly wants the deepest possible analysis and cost is not a concern. It often adds a lot of cost for a small quality gain.

## Quick lookup by task type

Use this when the user wants a fast answer and the task clearly matches a row. Run the full scoring for anything that doesn't.

| Task type | Starting point |
|---|---|
| Reformatting, extraction, translation, classification, short summaries | Haiku 5.5, low |
| Chat, quick questions, short emails | Haiku 5.5 low, or Sonnet 5.5 low |
| Summarising long documents | Sonnet 5.5, medium |
| Drafting reports, articles, standard documents | Sonnet 5.5, medium |
| Well-specified coding tasks, writing tests, small features | Sonnet 5.5, medium |
| Data analysis with clear questions | Sonnet 5.5, medium to high |
| Debugging an unknown cause, refactoring across many files | Opus 5.5, high |
| Strategy, architecture or decisions with trade-offs | Opus 5.5, high |
| Long autonomous coding or research sessions | Opus 5.5 xhigh, or Fable 5.1 high |
| Deep multi-source research carried through to a finished deliverable | Fable 5.1, high |

## Effort notes per model (from Anthropic's docs)

- **Haiku 5.5**: default medium. Low for chat, short tool tasks and simple high-volume requests (at low it may skip searches or checks in long agent prompts). High for knowledge work, longer agent tasks and strict instruction following.
- **Sonnet 5.5**: default high on the API. Medium for well-specified agentic coding, high for harder or longer tasks, medium or low for chat and latency-sensitive work.
- **Opus 5.5**: default medium. Adaptive thinking is always on, so effort is the main cost control.
- **Fable 5.1**: default high. Step up to xhigh or max for the most capability-sensitive agentic and coding work; step down to medium or low for routine work.
