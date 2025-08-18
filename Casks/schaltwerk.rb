cask "schaltwerk" do
  version "0.1.1"
  sha256 "60a5310592f07c9cbab50da88256e2ff6d4f331c41811db903ccfa868ccb46fc"

  url "https://github.com/2mawi2/para-ui/releases/download/v#{version}/Schaltwerk-#{version}-universal.dmg"
  name "Schaltwerk"
  desc "Visual interface for managing Para sessions"
  homepage "https://github.com/2mawi2/para-ui"

  app "Schaltwerk.app"

  postflight do
    # Remove quarantine attribute
    system_command "/usr/bin/xattr",
                  args: ["-cr", "#{appdir}/Schaltwerk.app"],
                  sudo: false
    
    # Ad-hoc sign if needed
    system_command "/usr/bin/codesign",
                  args: ["--force", "--deep", "-s", "-", "#{appdir}/Schaltwerk.app"],
                  sudo: false
  end

  zap trash: [
    "~/Library/Application Support/schaltwerk",
    "~/Library/Logs/schaltwerk",
    "~/Library/Preferences/com.mariuswichtner.schaltwerk.plist",
    "~/Library/Saved Application State/com.mariuswichtner.schaltwerk.savedState",
  ]
end
