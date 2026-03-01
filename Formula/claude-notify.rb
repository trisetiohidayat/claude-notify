# typed: false
# frozen_string_literal: true

class ClaudeNotify < Formula
  desc "Desktop notifications for Claude Code"
  homepage "https://github.com/trisetiohidayat/claude-notify"
  url "https://github.com/trisetiohidayat/claude-notify/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "977409ba258c0a024b88c016d776eb260f27004ac03e82db3ff98489223d4977"
  license "MIT"

  depends_on "terminal-notifier"
  depends_on "jq"

  def install
    bin.install "bin/claude-notify"
    lib.install "lib/notify.sh"
    etc.install "config/default.json" => "claude-notify-default.json"
  end

  def post_install
    config_dir = Dir.home/".claude-notify"
    config_file = config_dir/"config.json"
    default_config = etc/"claude-notify-default.json"

    config_dir.mkpath
    cp default_config, config_file unless config_file.exist?
  end

  test do
    system bin/"claude-notify", "help"
  end
end
