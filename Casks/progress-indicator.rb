cask "progress-indicator" do
  version "1.0.1"
  sha256 "79a178970399fdbd62e87d923b7ec918a7ca2e3e35587ece34d98484bb6c4853"

  url "https://github.com/smartwatermelon/swift-progress-indicator/releases/download/v#{version}/ProgressIndicator-#{version}.tar.gz"
  name "ProgressIndicator"
  desc "Displays real-time progress updates from log files"
  homepage "https://github.com/smartwatermelon/swift-progress-indicator"

  binary "ProgressIndicator"

  # Strips the quarantine flag Homebrew applies to cask downloads, so the
  # binary runs without a Gatekeeper prompt. Intentional, and predates the
  # migration below.
  #
  # Uses the declarative `postflight_steps` stanza, not the legacy `postflight`
  # Ruby block, which Homebrew deprecated (it warns on every parse and asks
  # users to report it to this tap).
  # https://docs.brew.sh/Cask-Cookbook#stanza-flight_steps
  #
  # Two things here look wrong but are correct, per the docs:
  #   - `run` is the steps-DSL call for a command; a steps block takes only
  #     supported step calls, so `system_command` is not available inside it.
  #   - `{{staged_path}}` is deliberately NOT Ruby `#{...}` interpolation. It
  #     stays literal in the JSON API, and the install-step runner expands it
  #     at install time. The docs list `{{staged_path}}` as a supported token
  #     and prefer this explicit form in new steps.
  # https://docs.brew.sh/Cask-Cookbook#interpolation-in-steps-blocks
  #
  # Verified against Homebrew 6.0.22, not assumed. The failure mode worth
  # ruling out was a silent no-op: a stanza Homebrew ignores would leave the
  # binary quarantined while still "passing". It does not happen --
  #   - `Cask::DSL::DSL_METHODS.include?(:postflight_steps)` => true, and
  #     `Cask::Artifact::PostflightSteps.dsl_key` => :postflight_steps
  #   - the loaded cask reports `PostflightSteps: 1 install step`, so the
  #     stanza registers rather than being skipped
  #   - end to end: seeding `com.apple.quarantine` on the staged binary and
  #     running `brew reinstall --cask` removes it. Seeding first matters --
  #     without a known-bad starting state, a clean result would also be
  #     consistent with the step never running at all.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{staged_path}}/ProgressIndicator"]
  end

  # No uninstall stanza needed for simple binary

  zap trash: "~/Library/Preferences/com.progressindicator.*"
end
