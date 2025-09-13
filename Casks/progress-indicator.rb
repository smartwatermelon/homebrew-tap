cask "progress-indicator" do
  version "1.0.0"
  sha256 "53911fbb964da0b05824b1f48d24fe26228595b98c5926151fafbd636fec3e5b"

  url "https://github.com/smartwatermelon/swift-progress-indicator/releases/download/v#{version}/ProgressIndicator-#{version}.tar.gz"
  name "ProgressIndicator"
  desc "Lightweight macOS progress indicator that displays real-time updates from log files"
  homepage "https://github.com/smartwatermelon/swift-progress-indicator"

  binary "ProgressIndicator"

  # No uninstall stanza needed for simple binary

  zap trash: [
    "~/Library/Preferences/com.progressindicator.*",
  ]
end