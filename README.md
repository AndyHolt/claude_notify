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

2. Clone this repository:
   ```bash
   git clone <repository-url> ~/Projects/claude_notify
   ```

3. Make the notification script executable:
   ```bash
   chmod +x ~/Projects/claude_notify/notify.sh
   ```

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

Edit `notify.sh` to customize:
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
