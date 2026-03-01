# Claude Notify

> Desktop notifications for Claude Code - Get notified when Claude finishes processing or needs your input.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## Features

- 🔔 **Desktop Notifications** Get notified when:
  - Claude finishes responding
  - Claude needs your input (AskUserQuestion)
- ⚙️ **Configurable** Customize sound, title, and message
- 🎯 **Easy Installation** One command install with Homebrew
- 🔄 **Easy Management** Enable/disable without uninstalling

## Installation

### Requirements

- macOS 10.15+
- Claude Code CLI installed
- [Homebrew](https://brew.sh)
- [terminal-notifier](https://github.com/julienXX/terminal-notifier)
- [jq](https://stedolan.github.io/jq/)

### Install via Homebrew (Recommended)

```bash
brew tap trisetiohidayat/tap
brew install claude-notify
```

### Setup

After installation, run:

```bash
claude-notify install
```

This will:
1. Create configuration file at `~/.claude-notify/config.json`
2. Add hooks to `~/.claude/settings.json`
3. Create hook scripts in `~/.claude/hooks/`

**Important:** Restart Claude Code to activate the hooks.

## Usage

### Commands

```bash
# Install hooks
claude-notify install

# Uninstall hooks
claude-notify uninstall

# Edit configuration
claude-notify config

# Show status
claude-notify status

# Enable notifications
claude-notify enable

# Disable notifications
claude-notify disable

# Send test notification
claude-notify test

# Show help
claude-notify help
```

## Configuration

Edit `~/.claude-notify/config.json`:

```json
{
  "enabled": true,
  "sound": "Glass",
  "title": "Claude Code",
  "message": "Selesai memproses",
  "hooks": {
    "stop": true,
    "pre_tool_use": true
  }
}
```

### Available Sounds

- `Glass` (default) - Clear and pleasant
- `Ping` - Simple ping
- `Pop` - Quick pop
- `Tink` - High pitched
- `Frog` - Playful
- `Morse` - Classic
- Or any macOS system sound name

## How It Works

Claude Notify uses Claude Code's hook system:

1. **Stop Hook** - Fires when Claude finishes responding
2. **PreToolUse Hook** - Fires before AskUserQuestion tool

Hooks run notification scripts via `terminal-notifier`.

## Troubleshooting

### Notifications not appearing?

1. Check if enabled: `claude-notify status`
2. Test notification: `claude-notify test`
3. Check macOS notification permissions for "terminal-notifier"
4. Make sure Claude Code is restarted after install

### Notifications not appearing when DND is on?

This is expected behavior - Do Not Disturb blocks all notifications.

### Custom icon not showing?

macOS Ventura+ ignores custom notification icons for security. The icon will match your terminal app (VSCode, Terminal, etc.).

## Development

### Project Structure

```
claude-notify/
├── bin/              # CLI tool
│   └── claude-notify
├── lib/              # Core library
│   └── notify.sh
├── config/           # Default configuration
│   └── default.json
├── Formula/          # Homebrew formula
│   └── claude-notify.rb
└── README.md
```

### Local Testing

```bash
# Clone repo
git clone https://github.com/trisetiohidayat/claude-notify.git
cd claude-notify

# Link for testing
brew link --overwrite --force claude-notify

# Test
claude-notify install
claude-notify test
```

## Contributing

Contributions welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details.

## Acknowledgments

- [terminal-notifier](https://github.com/julienXX/terminal-notifier) for macOS notifications
- [Claude Code](https://code.anthropic.com) for the amazing AI assistant
