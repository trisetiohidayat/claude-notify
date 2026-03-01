# Submitting to Homebrew Core

## Prerequisites Checklist

- ✅ Repository is public on GitHub
- ✅ Stable release tag (v1.0.0) exists
- ✅ Formula follows Homebrew naming conventions
- ✅ GitHub Actions CI/CD is passing
- ✅ Formula tests locally with `brew install --formula`
- ✅ README is comprehensive
- ✅ License is specified (MIT)

## Step 1: Fork Homebrew/Core

```bash
# Fork homebrew/core on GitHub
# https://github.com/Homebrew/core/fork

# Clone your fork
git clone https://github.com/YOUR_USERNAME/core.git
cd core

# Add upstream remote
git remote add upstream https://github.com/Homebrew/core.git
```

## Step 2: Create Branch

```bash
git fetch upstream
git checkout main
git rebase upstream/main
git checkout -b claude-notify-v1.0.0
```

## Step 3: Copy Formula

```bash
# Copy your formula to the correct location
cp /path/to/claude-notify/Formula/claude-notify.rb \
   Formula/claude-notify.rb
```

## Step 4: Test Locally

```bash
# Audit the formula
brew audit --new-formula --strict Formula/claude-notify.rb

# Style check
brew style Formula/claude-notify.rb

# Test installation
brew uninstall claude-notify 2>/dev/null || true
brew install --build-from-source Formula/claude-notify.rb
claude-notify test

# Verify it works
claude-notify status
```

## Step 5: Commit and Push

```bash
git add Formula/claude-notify.rb
git commit -m "claude-notify 1.0.0 (new formula)

Desktop notifications for Claude Code with configurable
sound, title, and message. Supports automatic hook
installation and management."
```

```bash
git push -u origin claude-notify-v1.0.0
```

## Step 6: Create Pull Request

```bash
# Or create PR via GitHub web interface
gh pr create \
  --repo Homebrew/core \
  --title "claude-notify 1.0.0 (new formula)" \
  --body "## Description
Desktop notifications for Claude Code - get notified when
Claude finishes processing or needs your input.

## Features
- 🔔 Desktop notifications when Claude finishes
- ⚙️ Configurable sound, title, and message
- 🎯 One-command installation and setup
- 🔄 Easy enable/disable without reinstall

## Homepage
https://github.com/trisetiohidayat/claude-notify

## License
MIT

Closes #(PR number will be added by maintainer)"
```

## Step 7: Monitor PR

- Watch for CI/CD results on your PR
- Respond to maintainer feedback promptly
- Make requested changes in a new commit

## Alternative: Personal Tap

If PR to homebrew/core is rejected or delayed, use your own tap:

```bash
# Create tap repository
gh repo create tap --public

# Clone tap
git clone git@github.com:trisetiohidayat/tap.git
cd tap

# Create Formula directory
mkdir -p Formula

# Copy formula
cp /path/to/claude-notify/Formula/claude-notify.rb Formula/

# Commit and push
git add Formula/claude-notify.rb
git commit -m "Add claude-notify 1.0.0"
git push

# Users can now install:
brew tap trisetiohidayat/tap
brew install claude-notify
```

## Tips for Success

1. **Follow naming conventions**: `claude-notify` not `claude_notify`
2. **Keep formula simple**: No complex post_install logic
3. **Use stable dependencies**: `terminal-notifier` and `jq` are in homebrew/core
4. **Test thoroughly**: Both `brew audit` and manual testing
5. **Responsive to feedback**: Maintainers appreciate quick responses
6. **Patience**: PR review can take days to weeks

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew for Python Developers](https://docs.brew.sh/Python-for-Formula-Authors)
- [Homebrew CI/CD](https://docs.brew.sh/Homebrew-CI-CD)
