#!/bin/bash
# Claude Notify - Core Notification Library
# Supports configuration via ~/.claude-notify/config.json

# Default configuration
DEFAULT_SOUND="Glass"
DEFAULT_TITLE="Claude Code"
DEFAULT_MESSAGE="Selesai memproses"
DEFAULT_TERMINAL_APP="auto"  # auto-detect

# Config file locations
CONFIG_FILE="$HOME/.claude-notify/config.json"
CONFIG_DIR="$(dirname "$CONFIG_FILE")"

# Load configuration
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        # Parse JSON using bash (basic implementation)
        SOUND=$(grep -o '"sound"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | cut -d'"' -f4 2>/dev/null)
        TITLE=$(grep -o '"title"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | cut -d'"' -f4 2>/dev/null)
        MESSAGE=$(grep -o '"message"[[:space:]]*:[[:space:]]*"[^"]*"' "$CONFIG_FILE" | cut -d'"' -f4 2>/dev/null)
        ENABLED=$(grep -o '"enabled"[[:space:]]*:[[:space:]]*\(true\|false\)' "$CONFIG_FILE" | awk '{print $2}' 2>/dev/null)

        # Use defaults if not set in config
        SOUND="${SOUND:-$DEFAULT_SOUND}"
        TITLE="${TITLE:-$DEFAULT_TITLE}"
        MESSAGE="${MESSAGE:-$DEFAULT_MESSAGE}"
        ENABLED="${ENABLED:-true}"
    else
        SOUND="$DEFAULT_SOUND"
        TITLE="$DEFAULT_TITLE"
        MESSAGE="$DEFAULT_MESSAGE"
        ENABLED="true"
    fi
}

# Detect terminal app
detect_terminal_app() {
    if [ -n "$ITERM_SESSION_ID" ]; then
        echo "com.googlecode.iterm2"
    elif [ -n "$TERM_SESSION_ID" ]; then
        echo "com.apple.Terminal"
    else
        echo "com.microsoft.VSCode"
    fi
}

# Main notification function
send_notification() {
    local custom_title="${1:-}"
    local custom_message="${2:-}"

    load_config

    # Check if notifications are enabled
    if [ "$ENABLED" != "true" ]; then
        return 0
    fi

    # Use custom values if provided
    local final_title="${custom_title:-$TITLE}"
    local final_message="${custom_message:-$MESSAGE}"

    # Detect terminal app
    local terminal_app=$(detect_terminal_app)

    # Get current directory for vscode:// URL
    local current_dir="${PWD/#\//}"
    local vscode_url="vscode://file//$current_dir"

    # Send notification
    terminal-notifier \
        -title "$final_title" \
        -message "$final_message" \
        -sound "$SOUND" \
        -activate "$terminal_app" \
        -open "$vscode_url" 2>/dev/null

    return $?
}
