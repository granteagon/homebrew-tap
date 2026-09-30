# Grant Eagon's Homebrew tap

## ClipBar

A small native macOS clipboard history app. [Source, screenshots, and setup](https://github.com/granteagon/clipbar).

```sh
brew install granteagon/tap/clipbar
clipbar
```

Builds from source on macOS 13+ with Swift 5.9+ Command Line Tools. Enable Accessibility in ClipBar Settings → Shortcuts for automatic paste. The installed app lives under `$(brew --prefix clipbar)/libexec/ClipBar.app`.

Update with `brew upgrade granteagon/tap/clipbar`, then quit and reopen ClipBar. Local builds may need Accessibility approval renewed after upgrades. Quit and run `brew uninstall clipbar` to remove it. Saved preferences and optional encrypted history are retained; disable persistence and clear history in the app before uninstalling to remove saved entries.

This is an independent personal tap, not part of Homebrew's central catalog.
