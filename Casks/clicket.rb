cask "clicket" do
  version "1.0.9"
  sha256 "5bac534bdbca88bae3b10038af38189ae8521f3d9032afe634fb7e5a0443ed6e"

  url "https://github.com/2mawi2/clicket-releases/releases/download/v#{version}/Clicket.zip"
  name "Clicket"
  desc "Click anything from the keyboard with home-row labels"
  homepage "https://github.com/2mawi2/clicket-releases"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Clicket.app"

  # Not ad-hoc re-signed: every release carries the same certificate, which is
  # what lets the Accessibility grant survive an upgrade.
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
