cask "schaltwerk" do
  version "0.1.1"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

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
