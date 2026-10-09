# Rightsize benchmark

The rubric's credibility depends on measured results, not opinion. This folder holds the test tasks and the method for checking whether the rubric's predictions hold up.

## What `tasks.csv` contains

Fifteen seed tasks across common categories, each scored on the rubric's five dimensions with the model and effort the rubric predicts. The predictions are hypotheses until tested.

## Method

1. For each task, run the same prompt (with the same inputs) on at least three settings: the predicted setting, one step below it, and one step above it.
2. Grade each output as **acceptable** or **not acceptable**, judged as "would I use this without redoing it?". Where possible, use a checklist written before running the tasks, so grading isn't influenced by which model produced the output.
3. Record input and output tokens from the API response for each run.
4. The **right setting** for a task is the cheapest one that was acceptable.

## How results change the rubric

- Predicted setting fails, the step above passes: the rubric under-predicts for that task type. Adjust the dimension descriptions or add an override.
- The step below also passes: the rubric over-predicts. Consider moving that task type down.
- Aim for at most a 10% under-prediction rate, since redos are the most expensive failure.

## Contributing tasks

Add rows with real (anonymised) tasks from your own work. Real tasks are far more valuable than invented ones. Never include confidential data.

## Results

To be published in `results/` from v0.2 onward, with model versions and run dates, since results go stale when models change.
