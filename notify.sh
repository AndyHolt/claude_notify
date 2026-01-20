#!/bin/zsh
#
# File: notify.sh
# Description: Claude code notification script
# Usage: Call with a single argument, the message of notification
# Author: Andy Holt
# Date: Mon 19 Jan 2026 23:13

code_status="$1"

subtitle=""
sound=""

if [[ $code_status = "complete" ]]; then
    subtitle="Complete!"
    sound="Hero"
else
    subtitle="Input required!"
    sound="Frog"
fi

message=""

tmux_info=$(tmux display-message -p '#I: #W')
if [[ -n "$TMUX" ]]; then
    message+="tmux pane: ${tmux_info}\n"
fi

git_branch=""
git_worktree=""

if git rev-parse --git-dir > /dev/null 2>&1; then
    git_branch=$(git branch --show-current)
    git_worktree=$(basename "$(git rev-parse --show-toplevel)")
fi

if [[ -n $git_branch ]]; then
    message+="Branch: ${git_branch}\n"
fi
if [[ -n $git_worktree ]]; then
    message+="Worktree: ${git_worktree}\n"
fi

if [[ -z $message ]]; then
    message+="Unknown session"
fi

# Pipe message into command (instead of specifying -message argument) to preserve line breaks
echo "$message" | terminal-notifier \
    -title "Claude Code" \
    -subtitle "$subtitle" \
    -contentImage ~/claude.png \
    -sound "$sound"
