cask "schaltwerk" do
  version "0.1.26"
  sha256 "29ceba26cb51d9efaba57ff8614760b5679f2116d7f6706262e2478d0f596b58"

  url "https://github.com/2mawi2/homebrew-tap/raw/main/releases/Schaltwerk-#{version}-universal.dmg"
  name "Schaltwerk"
  desc "Visual interface for managing Para sessions"
  homepage "https://github.com/2mawi2/schaltwerk"

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
    
    # Create wrapper script for CLI with better handling
    wrapper_script = "#{HOMEBREW_PREFIX}/bin/schaltwerk"
    File.write wrapper_script, <<~SHELL
      #!/bin/bash
      APP_PATH="#{appdir}/Schaltwerk.app"
      EXECUTABLE_PATH="$APP_PATH/Contents/MacOS/Schaltwerk"
      
      if [ $# -eq 0 ]; then
        open "$APP_PATH"
      else
        TARGET_DIR="$1"
        [[ ! "$TARGET_DIR" = /* ]] && TARGET_DIR="$(pwd)/$TARGET_DIR"
        TARGET_DIR="${TARGET_DIR%/}"
        
        if [ ! -d "$TARGET_DIR" ]; then
          echo "Error: Directory not found: $TARGET_DIR" >&2
          exit 1
        fi
        
        "$EXECUTABLE_PATH" "$TARGET_DIR" &
      fi
    SHELL
    File.chmod 0755, wrapper_script
    
    ohai "Schaltwerk MCP configuration is now available through Settings → Agent Configuration → Claude tab."
  end

  zap trash: [
    "~/Library/Application Support/schaltwerk",
    "~/Library/Logs/schaltwerk",
    "~/Library/Preferences/com.mariuswichtner.schaltwerk.plist",
    "~/Library/Saved Application State/com.mariuswichtner.schaltwerk.savedState",
  ]
end
