cask "clicket" do
  version "1.0.40"
  sha256 "7847771a45256e73f45a9f33b485d1f33593c2a3a820f97faa66eea7e4d00fb9"

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
