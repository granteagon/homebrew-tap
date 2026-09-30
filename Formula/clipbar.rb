class Clipbar < Formula
  desc "Native macOS clipboard history with configurable local retention"
  homepage "https://github.com/granteagon/clipbar"
  url "https://github.com/granteagon/clipbar/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8807c3fc15f51313df8c4269ff7632a0a10e0d62df0de6c1f0af188d3c54ce04"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "swift", "build", "--disable-sandbox", *std_swift_args
    app = buildpath/"ClipBar.app"
    (app/"Contents/MacOS").mkpath
    (app/"Contents/MacOS").install ".build/release/ClipBar"
    (app/"Contents").install "Resources/Info.plist"
    system "/usr/bin/codesign", "--force", "--sign", "-", "--options", "runtime", app
    libexec.install app
    (bin/"clipbar").write <<~SH
      #!/bin/bash
      if [ "${1:-}" = "--version" ]; then
        exec "#{opt_libexec}/ClipBar.app/Contents/MacOS/ClipBar" --version
      fi
      exec /usr/bin/open "#{opt_libexec}/ClipBar.app"
    SH
  end

  def caveats
    <<~EOS
      Launch ClipBar with:
        clipbar
      For automatic paste, enable Accessibility in ClipBar Settings > Shortcuts.
      The app is installed at:
        #{opt_libexec}/ClipBar.app
      Add that app to System Settings > General > Login Items to start at login.
      After upgrading, quit and reopen ClipBar. Locally signed upgrades may need
      their Accessibility entry removed and re-added for automatic paste.
    EOS
  end

  test do
    assert_equal "ClipBar #{version}", shell_output("#{bin}/clipbar --version").strip
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", libexec/"ClipBar.app"
    plist = libexec/"ClipBar.app/Contents/Info.plist"
    assert_match "com.granteagon.ClipBar",
      shell_output("/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' #{plist}")
  end
end
