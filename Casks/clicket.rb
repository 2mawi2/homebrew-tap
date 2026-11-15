cask "clicket" do
  version "1.0.87"
  sha256 "3b40e037178f8c99587eb684186e071c76c6fbc4361ab2a73808de30496a2589"

  url "https://github.com/2mawi2/clicket-releases/releases/download/v#{version}/Clicket.zip"
  name "Clicket"
  desc "Click anything from the keyboard with home-row labels"
  homepage "https://github.com/2mawi2/clicket-releases"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Clicket.app"

  # Not ad-hoc re-signed: every release carries the same certificate, which is
  # what lets the Accessibility grant survive an upgrade. A legacy flight block
  # because postflight_steps has no step for the quarantine flag, and a
  # self-signed app that keeps it is blocked by Gatekeeper on first launch.
  postflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{appdir}/Clicket.app"], sudo: false
  end

  uninstall quit: "com.2mawi2.clicket"

  zap trash: [
    "~/Library/Application Support/MyHomerow",
    "~/Library/Logs/MyHomerow",
    "~/Library/Preferences/com.2mawi2.clicket.plist",
  ]
end
