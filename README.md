# sharpen

A Claude Code skill that turns a rough prompt into a sharp, agreed brief **before** any expensive work
starts, and pushes you to think the idea through while it does that. It works for any field: websites,
redesigns, motion, code, writing, research, strategy, personal decisions.

The aim: no more "build something mediocre, then spend three rounds refining it".

## How it works

```
your rough prompt
      │
      ▼
 0. Triage ──── clear or cheap to redo? ──► GO: "Building X, assuming Y." No questions.
      │
      │ fuzzy and costly                    idea not formed yet? ──► THINK: thinking-partner mode
      ▼
 1. Gather    reads the repo, files, earlier briefs and your profile; never asks what it can find out
 2. Decompose outcome · audience · success test · scope · constraints · taste · field-specific lens
 3. Sort      every unknown becomes a stated default OR a "fork question" (max 4)
 4. Ask       "Here's what I think you want" + fork questions with options + one provocation
 5. Probe     for taste-heavy work: 2–3 really different cheap directions before the full build
 6. Lock      final brief + acceptance checklist → build → check every item before saying "done"
      │
      ▼
 Learning loop: stable preferences go to ~/.claude/sharpen/profile.md, so it asks less over time
```

### What makes it different from "ask clarifying questions"

- **Triage first.** Most prompts don't need sharpening. Clear or cheap tasks go straight through, so you only pay for questions when a wrong guess would really cost you.
- **Fork questions only.** It asks only questions whose answers would produce clearly different work. Everything else becomes a stated default that you can correct.
- **Mirror before asking.** It shows "here's what I think you want" with assumptions marked. Correcting a wrong guess is faster than answering a questionnaire.
- **Options, not open questions.** "Editorial and calm / Bold and brutalist / Playful with 3D", with a recommendation, instead of "what style do you want?".
- **One provocation per round.** A single question meant to sharpen your own thinking ("Imagine the result disappoints you. Why?"), not to fill a form.
- **Cheap probes for taste.** Design, motion and tone are hard to put into words, so it shows small, clearly different directions before building the real thing.
- **Acceptance checklist.** "Done" is checked against what you agreed, not against what Claude felt like building.
- **It remembers your taste.** Saved preferences mean fewer questions next time.
- **Field lenses.** Each field has its own list of things people forget to say (see `skills/sharpen/references/lenses.md`).

## Install

**As a plugin (recommended: includes the auto-trigger hook)**

```
/plugin marketplace add zaharipi4a/prompt_refinement
/plugin install sharpen@prompt-refinement
```

**As a plain skill (no hook: triggers on its own description or via /sharpen)**

```bash
git clone https://github.com/zaharipi4a/prompt_refinement.git
mkdir -p ~/.claude/skills && cp -r prompt_refinement/skills/sharpen ~/.claude/skills/
```

## Use

| You type | What happens |
|---|---|
| any normal prompt | With the plugin's hook, Claude triages it. Clear prompts go straight through; fuzzy, costly ones get sharpened. |
| `/sharpen landing page for my bakery` | Full sharpen run. |
| `/sharpen ... --quick` | At most 2 questions, no probe. |
| `/sharpen ... --deep` | Every step, including a direction probe. |
| `/sharpen ... --think` | Thinking-partner mode for ideas that aren't formed yet. |
| `... --raw` anywhere in a prompt | The hook stays silent for that prompt. |

## Layout

```
.claude-plugin/        plugin + marketplace manifests
hooks/                 UserPromptSubmit hook that triggers triage on new requests
skills/sharpen/
  SKILL.md             the workflow
  references/
    lenses.md          field-specific blind spots
    provocations.md    thinking prompts
    brief-template.md  the brief + acceptance checklist format
```

## Ideas for later

- `/sharpen review`: compare a finished build with its brief and list where they differ.
- Per-project profiles (`.briefs/profile.md`) on top of the global one.
- A "taste board" artifact: probe directions shown visually side by side.
