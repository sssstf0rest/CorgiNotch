## CorgiNotch 2.2.4

The first official release of CorgiNotch.

CorgiNotch is the maintained continuation of [MewNotch](https://github.com/monuk7735/mew-notch) by [monuk7735](https://github.com/monuk7735). This release focuses on stabilizing the core notch experience, fixing packaging and updater issues, and preparing the project for ongoing maintenance on current macOS versions.

## Highlights

- First official public release of CorgiNotch
- Maintained continuation fork of MewNotch
- Improved compatibility and reliability for recent macOS releases
- Sparkle update flow set up for future in-app updates
- New DMG packaging flow for drag-and-drop installation

## Included in This Release

- Collapsed notch HUDs for brightness, audio, and media
- Expanded now playing view with playback controls
- Source app shortcut from the now playing app badge
- Multi-display notch support
- Hover-to-expand and glass-effect defaults enabled
- Settings window, menu bar controls, and launch at login support

## Fixes and Improvements

- Fixed packaged app builds that could fail to launch outside Xcode
- Fixed settings window opening behind other windows
- Fixed `Check for Updates` startup and availability regressions
- Fixed About page version display
- Fixed `Show on Lock Screen` not respecting the disabled state
- Fixed `Show on Lock Screen` failing to re-enable after being turned back on
- Fixed custom Audio and Brightness step-size behavior so `0%` now reaches true zero
- Simplified Collapsed Audio and Brightness settings by removing unused style options
- Restored always-visible step size controls in Audio and Brightness settings
- Improved alignment and consistency in collapsed settings UI

## Release Packaging

- `CorgiNotch-2.2.4.zip` is the Sparkle update archive
- `CorgiNotch-2.2.4.dmg` is provided for manual drag-and-drop installation

## Notes

This release is focused on stability, packaging, updater infrastructure, and core UX cleanup. It does not add new major end-user features yet. Future releases will continue the maintenance work, fix remaining bugs, and gradually implement the unfinished roadmap inherited from MewNotch.

## Credits

- Original project: [MewNotch](https://github.com/monuk7735/mew-notch)
- Original author: [monuk7735](https://github.com/monuk7735)
