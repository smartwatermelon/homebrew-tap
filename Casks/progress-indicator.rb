cask "progress-indicator" do
  version "1.0.1"
  sha256 "79a178970399fdbd62e87d923b7ec918a7ca2e3e35587ece34d98484bb6c4853"

  url "https://github.com/smartwatermelon/swift-progress-indicator/releases/download/v#{version}/ProgressIndicator-#{version}.tar.gz"
  name "ProgressIndicator"
  desc "Lightweight macOS progress indicator that displays real-time updates from log files"
  homepage "https://github.com/smartwatermelon/swift-progress-indicator"

  binary "ProgressIndicator"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{staged_path}/ProgressIndicator"],
                   sudo: false
  end

  # No uninstall stanza needed for simple binary

  zap trash: [
    "~/Library/Preferences/com.progressindicator.*",
  ]
end