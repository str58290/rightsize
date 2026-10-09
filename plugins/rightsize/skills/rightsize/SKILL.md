---
name: rightsize
description: Checks whether the current Claude model and effort level suit a task, and recommends the cheapest setting that will do it well. Use this automatically as a pre-check before starting any substantial new task (multi-step work, code changes across files, analysis, research, or writing longer than a short reply) whenever the user's preferences, CLAUDE.md, or session context ask for a rightsize pre-check. Also use it whenever the user asks which model, tier, or effort level to use (Haiku, Sonnet, Opus, Fable; low, medium, high, xhigh, max), wants to save tokens, usage limits or API cost, says "rightsize", or is planning subagents, workflows or API calls that each need a model and effort setting.
---

# Rightsize

Make sure each task runs on the lowest-cost Claude model and effort level that will still do it well. The goal is fewer wasted tokens, not the cheapest possible answer: a failed cheap run that has to be redone costs more than getting it right the first time.

This skill has two modes. Work out which one applies before doing anything else.

- **Pre-check mode**: the user gave you a task, and a standing instruction (preferences, CLAUDE.md, or session context from the rightsize plugin) asks you to check before executing. The user did not ask about models.
- **Recommendation mode**: the user asked directly which model or effort to use, or asked for a plan with a setting per step.

## Pre-check mode

The pre-check must be nearly invisible when the model fits. Most tasks should pass silently.

### 1. Decide whether to check at all

Skip the check entirely, and just do the task, for:
- quick questions, chat, and short factual answers
- follow-ups and revisions within a task that has already been checked
- small edits (a sentence, a few lines of code)
- any task where you cannot tell which model you are running on

Check only at the start of a substantial new task. Never check the same task twice, and if the user has already declined a switch for this task, don't raise it again.

### 2. Score the task

Read `references/rubric.md`, score the task, and get the recommended model. Do this in your own reasoning; do not show the scoring.

### 3. Compare with the current model

Order the tiers Haiku < Sonnet < Opus < Fable, and compare the recommendation with the model you are running on.

| Situation | What to do |
|---|---|
| Current model matches, or is one tier above for a short task | Say nothing about models. Do the task. |
| Current model is one tier above for a long or heavy task, or two or more tiers above | **Overpowered.** See the overpowered rule below. |
| Current model is below the recommendation | **Underpowered.** Pause before starting, because a weak first attempt usually gets redone. |

Overpowered rule: if the task is short (a single reply), mention it in one line at the top and continue, since switching would cost more than it saves. If the task is long or heavy (many steps, large output, an agentic run), pause and ask before starting, because that's where the savings are.

Only comment on effort if you know the current effort level and it is clearly wrong for the task (for example, low effort on a long agentic run). Otherwise judge the model only.

### 4. Wording

Keep any flag to one or two lines, then either continue or wait, as the table says. Name the switch and the reason. Examples:

> Heads up: this is a Haiku-level task (reformatting), so you could switch to save usage. Continuing here.

> This is a long, mechanical job that Sonnet at medium effort would handle well. Want to switch before I start, or should I go ahead on Opus?

> This needs deeper reasoning than Haiku is likely to manage (debugging an unknown cause across several files). I'd suggest Opus at high effort. Switch, or should I try here anyway?

In Claude Code, also mention the plugin's subagents when they fit, for example: "I'll hand the file search to rightsize:light-worker and keep the design work here."

Whatever the user decides, respect it and don't argue.

## Recommendation mode

1. If the user hasn't described the task, ask for a one-line description.
2. Score it with `references/rubric.md` and apply the overrides. Check `references/models.md` for current model IDs, aliases and supported effort levels. On a boundary, or when unsure, go one step up.
3. Answer in this format, in no more than six lines:

   ```
   Recommendation: <Model> at <effort> effort
   Why: <one sentence naming the deciding dimensions>
   Step down if: <signal that a cheaper setting would do>
   Step up if: <signal that it needs more>
   How to set it: <one line for the user's surface>
   ```

   For "How to set it": the model picker in Claude.ai; `/model <alias>` and `/effort <level>` in Claude Code (or a rightsize subagent when the plugin is installed); `model` and `output_config.effort` in an API call.

For multi-step work (a workflow, an agent pipeline, a project), recommend a setting per step in a short table: step, model, effort, reason. Bulk mechanical steps usually belong on a cheaper tier, with a stronger model kept for planning, judgment and final review.

## Rules for both modes

- Do not recommend models that are not generally available (such as Mythos-tier models restricted to verified organizations) unless the user says they have access.
- Do not invent prices or benchmark numbers. For cost questions, point to the pricing page in `references/models.md`.
- Treat the rubric as a starting point seeded from Anthropic's documentation. The user's own experience with their tasks overrides it.
