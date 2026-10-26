---
name: sharpen
description: Turns a rough request into a sharp, agreed brief before any expensive work starts, and pushes the user to think the idea through. Use when the user invokes /sharpen, or when a request to build, design, write, animate, research or decide something is vague, underspecified or open to very different readings, and getting it wrong would waste a full build-and-redo cycle. Works in any field. Skip it for clear, small or easily reversible tasks.
argument-hint: "[rough idea] [--quick | --deep | --think]"
---

# Sharpen

People usually know what they want better than their first prompt says. Your job is to pull out the
missing half of the idea **before** you build, at the lowest possible cost to them, and to leave them
thinking more clearly than when they started.

The core rule: **a wrong guess that becomes a finished build costs far more than one good question.**
The counter-rule: **a question you could have answered yourself is a tax.** Sharpen sits between those two.

## Step 0: Triage (always, silently)

Rate the request on two axes:

- **Clarity**: could two competent people read it and build roughly the same thing?
- **Cost of a wrong guess**: minutes of rework, or hours plus a lot of tokens?

Then pick a track:

| Track | When | What you do |
|---|---|---|
| **Go** | Clear, or cheap to redo | One line: "Building X, assuming Y." Then build. No questions. |
| **Sharpen** | Fuzzy and costly | Steps 1–6 below. |
| **Think** | The idea itself isn't formed yet ("I want to do something with…") | Thinking-partner mode (see below), then Sharpen. |

Flags override triage: `--quick` = Sharpen with at most 2 questions and no probe; `--deep` = all steps,
including a probe; `--think` = Think track.

## Step 1: Gather what you can find out yourself

Before asking anything, read the context: the repo or existing files, earlier messages, previous
briefs in `.briefs/`, and the user's profile at `~/.claude/sharpen/profile.md` if it exists. Anything
you can learn there, you don't ask about. If the user has a preference on record, apply it and mention it.

## Step 2: Decompose the request

Fill these slots. For each one, note whether it was **stated**, **inferred** (with your reasoning), or **unknown**.

1. **Outcome**: what changes in the world when this is done? (Not "a landing page" but "people sign up for the beta".)
2. **Audience**: who uses or sees it, and what do they already know?
3. **Success test**: how will the user judge it in the first 10 seconds, and after a week?
4. **Scope**: what is in, and what is explicitly out (non-goals)?
5. **Constraints**: stack, platform, brand, deadline, budget, length, accessibility, performance.
6. **Taste**: references, adjectives, things they hate. This is the slot most often missing, and the most expensive to guess wrong.
7. **Domain specifics**: open [references/lenses.md](references/lenses.md) and use the lens for the field
   (web/UI, motion, code, writing, research, data, product, decisions…). It lists the dimensions people
   most often leave out.

## Step 3: Sort the unknowns

For each unknown, ask: *would different answers produce clearly different work?*

- **No, or the difference is cheap to fix later** → choose a sensible default and list it as an assumption.
- **Yes** → it becomes a **fork question**.

Keep at most 4 fork questions. If you have more, the request is too big: propose splitting it into phases
and sharpen only the first phase.

## Step 4: Show the brief and ask the fork questions (one round)

Send one message with:

1. **"Here's what I think you want"**: the draft brief in 4–8 lines, with assumptions marked `[assumed]`.
   Correcting a wrong assumption is much cheaper for the user than answering a question from scratch.
2. **The fork questions**, using the AskUserQuestion tool when it is available. Rules for each question:
   - Concrete options, not open prompts. Not "what style do you want?" but
     "Editorial and calm / Bold and brutalist / Playful with 3D".
   - Recommended option first, with a short reason.
   - Each option says what it would change in the result.
3. **One provocation**: a single question meant to make them think, not to fill a slot. Pick the one most
   likely to change their mind, from [references/provocations.md](references/provocations.md).
   Make it optional ("worth a thought, no need to answer").

Normally one round is enough. Go to a second round only if an answer opens up a new fork. Never three.

## Step 5: Probe (taste-heavy or high-cost work only)

When the risk is taste (visual design, motion, tone of voice, naming), words aren't enough. Build the
**cheapest thing that settles the taste question** before the full build:

- 2–3 clearly different directions, 3 lines each (mood, typography/colour/motion or tone, one reference), or
- a single static frame, one paragraph in each of three voices, one hero section, one easing curve demo.

Make the directions really different from each other; three variations of the same idea settle nothing.
Let them pick or mix ("A's layout with C's colours").

## Step 6: Lock, build, check

1. Write the **final brief** with [references/brief-template.md](references/brief-template.md): outcome,
   audience, scope / non-goals, constraints, chosen direction, and an **acceptance checklist** of
   3–7 items that can be checked.
2. For multi-step or multi-session work in a project, save it to `.briefs/YYYY-MM-DD-<slug>.md` so later
   sessions build on it instead of guessing again.
3. Build.
4. Before you say it's done, go through the acceptance checklist item by item and report each one honestly.

## Learning loop

When the user states a preference that will likely hold across projects ("I always want dark mode",
"never use Inter", "I write in British English", "keep answers short"), offer once to save it to
`~/.claude/sharpen/profile.md` as a one-line entry under a heading for its field. Save only with their
agreement. Over time the profile means fewer questions: that is the goal.

## Think track (thinking-partner mode)

Use this when the user is still forming the idea. Don't jump to building. In one message:

1. Repeat the idea back in one sentence, stronger and more specific than they said it.
2. Name the **real decision** underneath it (often not the one they asked about).
3. Give 2–3 clearly different angles on it, each with its strongest argument and its biggest risk.
4. Ask the 1–2 questions that would decide between them.

When the idea settles, move to the Sharpen track and make a brief.

## Anti-patterns

- Asking what the repo, the files or the conversation already answer.
- Questionnaires: more than 4 questions, or questions with no options.
- Asking about things that don't change the output ("Do you want clean code?").
- Hiding a big assumption inside the build instead of stating it.
- Three "directions" that are really one direction.
- Sharpening a two-line fix. Triage exists to stop that.
- Lecturing. Provocations are one sentence, never a paragraph.
