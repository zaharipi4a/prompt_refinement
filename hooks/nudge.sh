#!/usr/bin/env bash
# UserPromptSubmit hook: reminds Claude to triage each new request with the sharpen skill.
# It stays silent for slash commands, short follow-ups ("yes", "go"), and prompts containing --raw.

input="$(cat)"

prompt=""
if command -v python3 >/dev/null 2>&1; then
  prompt="$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("prompt",""))' 2>/dev/null)"
elif command -v node >/dev/null 2>&1; then
  prompt="$(printf '%s' "$input" | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>{try{console.log(JSON.parse(s).prompt||"")}catch{}})' 2>/dev/null)"
fi

# If the prompt can't be parsed, nudge anyway: Claude's triage decides.
if [ -n "$prompt" ]; then
  case "$prompt" in
    /*) exit 0 ;;
    *--raw*) exit 0 ;;
  esac
  [ "${#prompt}" -lt 40 ] && exit 0
fi

echo "[sharpen] If this is a new request to build, design, write, research or decide something, triage it with the sharpen skill first: go straight ahead when it is clear or cheap to redo; otherwise sharpen it before building. Ignore this for follow-ups and answers to your own questions."
