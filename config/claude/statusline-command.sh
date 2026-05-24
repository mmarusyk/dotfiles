#!/usr/bin/env bash
# Claude Code status line script

input=$(cat)

# ── Model ────────────────────────────────────────────────────────────────────
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "unknown"')

# ── Effort ───────────────────────────────────────────────────────────────────
effort=$(echo "$input" | jq -r '.effort.level // empty')

# ── Context usage % ──────────────────────────────────────────────────────────
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  ctx_bar=$(python3 -c "
pct = float('$used_pct')
total = 10
filled = round(pct / 100 * total)
bar = '█' * filled + '░' * (total - filled)
print(f'{bar} {pct:.0f}%')
" 2>/dev/null)
  [ -z "$ctx_bar" ] && ctx_bar="---------- --"
else
  ctx_bar="---------- --"
fi

# ── USD spend ─────────────────────────────────────────────────────────────────
# Pricing per million tokens (USD), approximate for Sonnet-class models
# Input: $3/M  Cache-write: $3.75/M  Cache-read: $0.30/M  Output: $15/M

transcript=$(echo "$input" | jq -r '.transcript_path // empty')

# Current-call token usage (fallback when transcript has no costUSD entries)
cur_input=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cur_output=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0')
cur_cache_write=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cur_cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')

# Compute USD for current conversation by summing all API calls in transcript
conv_usd="?.??"
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  total_usd=$(python3 -c "
import json

path = '$transcript'
total = 0.0
try:
    with open(path) as f:
        for line in f:
            line = line.strip().rstrip(',')
            if not line or line in ('[', ']'):
                continue
            try:
                obj = json.loads(line)
            except Exception:
                continue
            if 'costUSD' in obj:
                total += float(obj['costUSD'])
                continue
            usage = None
            if 'message' in obj and isinstance(obj['message'], dict):
                usage = obj['message'].get('usage', {})
            elif 'usage' in obj:
                usage = obj['usage']
            if usage:
                inp = usage.get('input_tokens', 0) or 0
                out = usage.get('output_tokens', 0) or 0
                cw  = usage.get('cache_creation_input_tokens', 0) or 0
                cr  = usage.get('cache_read_input_tokens', 0) or 0
                total += (inp * 3 + cw * 3.75 + cr * 0.30 + out * 15) / 1_000_000
except Exception:
    pass
print(f'{total:.4f}')
" 2>/dev/null)
  if [ -n "$total_usd" ] && [ "$total_usd" != "0.0000" ]; then
    conv_usd=$(python3 -c "print(f'{float(\"$total_usd\"):.2f}')" 2>/dev/null)
  elif [ "$total_usd" = "0.0000" ]; then
    # Fall back to current-call estimate
    conv_usd=$(python3 -c "
inp=$cur_input; out=$cur_output; cw=$cur_cache_write; cr=$cur_cache_read
total=(inp*3 + cw*3.75 + cr*0.30 + out*15)/1_000_000
print(f'{total:.2f}')
" 2>/dev/null)
  fi
fi

# Daily USD spend: sum over all transcript files modified today
claude_projects_dir="$HOME/.claude/projects"
day_usd="?.??"
if [ -d "$claude_projects_dir" ]; then
  raw_day=$(python3 -c "
import os, json, glob
from datetime import datetime, date

today = date.today()
projects_dir = os.path.expanduser('$claude_projects_dir')
total = 0.0
for fpath in glob.glob(os.path.join(projects_dir, '**', '*.jsonl'), recursive=True):
    try:
        mtime = os.path.getmtime(fpath)
        if datetime.fromtimestamp(mtime).date() != today:
            continue
        with open(fpath) as f:
            for line in f:
                line = line.strip().rstrip(',')
                if not line or line in ('[', ']'):
                    continue
                try:
                    obj = json.loads(line)
                except Exception:
                    continue
                if 'costUSD' in obj:
                    total += float(obj['costUSD'])
                    continue
                usage = None
                if 'message' in obj and isinstance(obj['message'], dict):
                    usage = obj['message'].get('usage', {})
                elif 'usage' in obj:
                    usage = obj['usage']
                if usage:
                    inp = usage.get('input_tokens', 0) or 0
                    out = usage.get('output_tokens', 0) or 0
                    cw  = usage.get('cache_creation_input_tokens', 0) or 0
                    cr  = usage.get('cache_read_input_tokens', 0) or 0
                    total += (inp * 3 + cw * 3.75 + cr * 0.30 + out * 15) / 1_000_000
    except Exception:
        pass
print(f'{total:.2f}')
" 2>/dev/null)
  [ -n "$raw_day" ] && day_usd="$raw_day"
fi

# ── Elapsed time ─────────────────────────────────────────────────────────────
elapsed="--:--"
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  start_epoch=$(stat -c %W "$transcript" 2>/dev/null || stat -c %Y "$transcript" 2>/dev/null)
  if [ -n "$start_epoch" ] && [ "$start_epoch" -gt 0 ] 2>/dev/null; then
    now_epoch=$(date +%s)
    diff=$(( now_epoch - start_epoch ))
    h=$(( diff / 3600 ))
    m=$(( (diff % 3600) / 60 ))
    s=$(( diff % 60 ))
    if [ "$h" -gt 0 ]; then
      elapsed=$(printf "%d:%02d:%02d" "$h" "$m" "$s")
    else
      elapsed=$(printf "%02d:%02d" "$m" "$s")
    fi
  fi
fi

# ── user@host ─────────────────────────────────────────────────────────────────
user_host="$(whoami)@$(hostname -s)"

# ── Current folder ───────────────────────────────────────────────────────────
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
[ -z "$cwd" ] && cwd=$(pwd)
folder=$(basename "$cwd")

# ── Git branch ───────────────────────────────────────────────────────────────
branch=""
if command -v git &>/dev/null; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
fi

# ── Assemble status line ──────────────────────────────────────────────────────
C_RESET='\033[0m'
C_CYAN='\033[36m'
C_YELLOW='\033[33m'
C_GREEN='\033[32m'
C_MAGENTA='\033[35m'
C_BLUE='\033[34m'
C_WHITE='\033[37m'
C_DIM='\033[2m'

parts=""

model_str="$model"
[ -n "$effort" ] && model_str="$model_str ($effort)"
parts="${parts}$(printf "${C_CYAN}%s${C_RESET}" "$model_str")"

parts="${parts}  $(printf "${C_YELLOW}%s${C_RESET}" "$ctx_bar")"

parts="${parts}  $(printf "${C_GREEN}\$%s / \$%s${C_RESET}" "$conv_usd" "$day_usd")"

parts="${parts}  $(printf "${C_DIM}%s${C_RESET}" "$elapsed")"

parts="${parts}  $(printf "${C_MAGENTA}%s${C_RESET}" "$user_host")"

parts="${parts}  $(printf "${C_BLUE}%s${C_RESET}" "$folder")"

if [ -n "$branch" ]; then
  parts="${parts}  $(printf "${C_WHITE}%s${C_RESET}" "$branch")"
fi

printf "%b\n" "$parts"
