cask "clicket" do
  version "1.0.73"
  sha256 "c7e43a5c75662ef158c8c8f06a7b1298c420afc58789f75d14216b5fb3941768"

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
