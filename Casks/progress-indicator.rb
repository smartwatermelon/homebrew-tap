cask "progress-indicator" do
  version "1.0.0"
  sha256 "TBD_AFTER_GITHUB_RELEASE"

  url "https://github.com/andrewrich/swift-progress-indicator/releases/download/v#{version}/ProgressIndicator-#{version}.tar.gz"
  name "ProgressIndicator"
  desc "Lightweight macOS progress indicator that displays real-time updates from log files"
  homepage "https://github.com/andrewrich/swift-progress-indicator"

  binary "ProgressIndicator"

  # No uninstall stanza needed for simple binary

  zap trash: [
    "~/Library/Preferences/com.progressindicator.*",
  ]
end