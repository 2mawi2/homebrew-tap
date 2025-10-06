cask "schaltwerk" do
  version "0.2.14"
  sha256 "26c234baa5668fbb45aaacad43758270975afd9c9c0db283eac647a2e3da7785"

  url "https://github.com/2mawi2/homebrew-tap/raw/main/releases/Schaltwerk-#{version}-universal.dmg"
  name "Schaltwerk"
  desc "Visual interface for managing Para sessions"
  homepage "https://github.com/2mawi2/schaltwerk"

  uninstall_preflight do
    staged_app = staged_path/"Schaltwerk.app"
    next unless staged_app.exist?

    # The staged path should normally be a symlink. If it is a real directory,
    # a previous upgrade was interrupted and left a full copy behind which
    # breaks subsequent upgrades. Clean it up before Homebrew runs move_back.
    next if staged_app.symlink?

    require "fileutils"
    FileUtils.rm_rf(staged_app)
  end

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

  uninstall delete: [
    "#{HOMEBREW_PREFIX}/bin/schaltwerk",
  ]

  zap trash: [
    "~/Library/Application Support/schaltwerk",
    "~/Library/Logs/schaltwerk",
    "~/Library/Preferences/com.mariuswichtner.schaltwerk.plist",
    "~/Library/Saved Application State/com.mariuswichtner.schaltwerk.savedState",
  ]
end
