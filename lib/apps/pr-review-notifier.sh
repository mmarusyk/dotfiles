#!/usr/bin/env bash

# pr-review-notifier — builds PRNotifier.app, the macOS notification helper for
# bin/pr-review-bot. Unlike terminal-notifier (deprecated API, ad-hoc signed,
# which recent macOS refuses to display or make clickable), this uses the modern
# UserNotifications framework, so macOS grants it authorization and delivers
# click-to-open + an "Open PR" button. Source: lib/apps/pr-review-notifier/main.swift.

_prnotifier_src="$ROOT_DIR/lib/apps/pr-review-notifier/main.swift"
_prnotifier_app="$HOME/Applications/PRNotifier.app"

_prnotifier_build() {
  local app="$_prnotifier_app"
  run_cmd mkdir -p "$HOME/Applications" "$app/Contents/MacOS"

  run_cmd swiftc "$_prnotifier_src" -O -o "$app/Contents/MacOS/PRNotifier" \
    -framework AppKit -framework UserNotifications

  if [[ "${DRY_RUN:-false}" != "true" ]]; then
    cat > "$app/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key>               <string>PRNotifier</string>
  <key>CFBundleDisplayName</key>        <string>PR Review Bot</string>
  <key>CFBundleIdentifier</key>         <string>com.mmarusyk.pr-review-notifier</string>
  <key>CFBundleExecutable</key>         <string>PRNotifier</string>
  <key>CFBundlePackageType</key>        <string>APPL</string>
  <key>CFBundleVersion</key>            <string>1.0</string>
  <key>CFBundleShortVersionString</key> <string>1.0</string>
  <key>LSUIElement</key>                <true/>
  <key>LSMinimumSystemVersion</key>     <string>11.0</string>
</dict>
</plist>
PLIST
  fi

  # Ad-hoc sign (a stable code identity is enough for the modern API to be
  # authorized) and register so Launch Services can relaunch it on click.
  run_cmd codesign --force --deep -s - "$app"
  run_cmd /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$app"
}

custom_install_pr_review_notifier() {
  case $DETECTED_OS in
    macos)
      command -v swiftc >/dev/null 2>&1 || {
        log_error "swiftc not found — install Xcode Command Line Tools (xcode-select --install)"
        return 1
      }
      _prnotifier_build
      log_info "PRNotifier.app installed -> $_prnotifier_app (grant notifications on first fire)"
      ;;
    *) log_info "pr-review-notifier is macOS-only; skipping on $DETECTED_OS" ;;
  esac
}

custom_update_pr_review_notifier() {
  case $DETECTED_OS in
    macos) _prnotifier_build ;;
    *)     log_info "pr-review-notifier is macOS-only; skipping on $DETECTED_OS" ;;
  esac
}

custom_destroy_pr_review_notifier() {
  case $DETECTED_OS in
    macos) run_cmd rm -rf "$_prnotifier_app" ;;
    *)     log_info "pr-review-notifier is macOS-only; skipping on $DETECTED_OS" ;;
  esac
}
