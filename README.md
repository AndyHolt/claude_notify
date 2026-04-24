# Claude Code Notifier

A notification system for [Claude Code](https://github.com/anthropics/claude-code) that sends macOS notifications when Claude requires input or completes tasks.

## Features

- **Smart Notifications**: Different sounds and messages for "input required" vs "task complete"
- **Context Aware**: Shows tmux pane, git branch, and worktree information
- **Visual**: Displays a custom Claude image with each notification
- **Configurable**: Uses Claude Code's hook system for seamless integration

## Requirements

- macOS
- [terminal-notifier](https://github.com/julienXX/terminal-notifier)
- [Claude Code](https://github.com/anthropics/claude-code)
- A Claude avatar image at `~/claude.png` (optional, for notification icon)

## Installation

1. Install terminal-notifier:
   ```bash
   brew install terminal-notifier
   ```

2. Clone this repository anywhere you like, then `cd` into it — the rest of
   the install steps assume you're in the repo root:
   ```bash
   git clone <repository-url>
   cd claude_notify
   ```

3. Make the notification script executable and symlink it onto your `PATH`
   (e.g. `~/.local/bin`, which should be on your `PATH`). The `ln -s` target
   must be the **absolute path** to the script on your machine — using
   `"$(pwd)/claude-notify.sh"` resolves it automatically from the repo root:
   ```bash
   chmod +x claude-notify.sh
   ln -s "$(pwd)/claude-notify.sh" ~/.local/bin/claude-notify
   ```

   The hook in `claude-settings.json` invokes `claude-notify` as a command
   rather than pointing at the script's location, so the repo can live
   anywhere as long as the symlink resolves on your `PATH`.

4. (Optional) Add a Claude avatar image to your home directory:
   ```bash
   # Download or create ~/claude.png
   ```

5. Configure Claude Code to use the hooks by copying the settings:
   ```bash
   # Copy or merge claude-settings.json into your Claude Code settings
   # Location varies by installation
   ```

## Configuration

The `claude-settings.json` file configures two hooks:

- **Notification Hook**: Triggers when Claude needs user input (plays "Frog" sound)
- **Stop Hook**: Triggers when Claude completes a task (plays "Hero" sound)

Each notification displays:
- Active tmux pane (if running in tmux)
- Current git branch
- Git worktree name

## Usage

Once configured, the notifications will automatically appear when:
- Claude is waiting for your input
- Claude has completed the requested task

The notification will help you stay productive by alerting you when Claude needs attention, even if you've switched to another application.

## Customization

Edit `claude-notify.sh` to customize:
- Notification sounds (lines 16, 19)
- Displayed information
- Notification icon path (line 52)

## Resources

- [Claude Code Docs: Hooks](https://code.claude.com/docs/en/hooks)
- Use `terminal-notifier -help` to get options for configuring notification
- Boris Buliga's blog post [Claude Code Notifications That Don't
  Suck](https://www.d12frosted.io/posts/2026-01-05-claude-code-notifications)
  was instructive and inspiring.

  Note that the code on his
  [github](https://github.com/d12frosted/environment/blob/master/claude/notify.sh)
  has been updated to remove the claude code app icon trick, as the
  `terminal-notifier` command often hangs when using it. I've replaced it
  instead with the `-contentImage` argument, which isn't quite so nice.
