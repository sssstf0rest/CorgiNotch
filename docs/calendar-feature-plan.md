# Calendar Feature Plan

## Goal
Add a Calendar feature to `CorgiNotch` as a new optional expanded-notch item, informed by `boring.notch` and shaped to fit `CorgiNotch`'s current 4-layer architecture.

## Reference Summary

### boring.notch
- Uses `EventKit` directly for both calendar events and reminders.
- Splits the feature into:
  - `CalendarService` / `CalendarServiceProviding`
  - `CalendarManager`
  - `CalendarModel`
  - `EventModel`
  - `CalendarView` with a date wheel and event list
  - Calendar settings for authorization state, show/hide, and source selection
- Integrates the calendar only in the expanded notch, next to other expanded content.
- Supports:
  - event access
  - reminder access
  - calendar selection
  - reminder list selection
  - deep links into System Settings privacy panes
  - deep links into Calendar / Reminders for individual items

### DynamicNotchKit
- Does not implement a calendar feature.
- Is useful as a notch/windowing reference only:
  - panel/window behavior
  - SwiftUI content hosting
  - notchless fallback concepts

## Recommended CorgiNotch Direction

### Product Fit
- Calendar should be implemented as a second `ExpandedNotchItem`, not as a collapsed HUD.
- It should live beside `Now Playing` in the current expanded-item ordering system.
- It should be independently enableable, orderable, and configurable from the existing `Expanded Items` settings page.

### Recommended V1 Scope
- Show events only.
- Request calendar full access through `EventKit`.
- Show a compact selected-day picker plus that day's events.
- Allow selecting which calendars are included.
- Open an event in Calendar when clicked.
- Handle empty state, denied permission state, and loading state cleanly.

### Recommended V1 Exclusions
- Reminders parity from `boring.notch`
- reminder completion toggles
- advanced attendance / participant UI
- multi-column calendar layouts
- month view

These can be follow-up iterations after the core events flow is stable.

## Proposed Architecture

### Infrastructure
- `CorgiNotch/Infrastructure/SystemAdapters/Calendar/CalendarService.swift`
  - EventKit wrapper
  - authorization checks
  - event fetching
  - EventKit change observation

### Feature Layer
- `CorgiNotch/Features/Calendar/Models/CalendarSourceModel.swift`
- `CorgiNotch/Features/Calendar/Models/CalendarEventModel.swift`
- `CorgiNotch/Features/Calendar/ViewModels/CalendarViewModel.swift`
- `CorgiNotch/Features/Calendar/Views/ExpandedCalendarView.swift`
- `CorgiNotch/Features/Calendar/Views/CalendarDayPickerView.swift`
- `CorgiNotch/Features/Calendar/Views/CalendarEventRowView.swift`
- `CorgiNotch/Features/Calendar/Settings/CalendarDefaults.swift`
- `CorgiNotch/Features/Calendar/Settings/ExpandedCalendarSettingsView.swift`

### Existing Integration Points
- `CorgiNotch/Shared/Models/ExpandedNotchItem.swift`
  - add `.calendar`
- `CorgiNotch/Features/AppSettings/ExpandedItemsSettingsView.swift`
  - add Calendar tab and settings view
- `CorgiNotch/Features/NotchPresentation/Views/NotchHomeView.swift`
  - render `ExpandedCalendarView` when enabled
- `CorgiNotch/Features/NotchPresentation/NotchDefaults.swift`
  - include calendar in defaults/order migration
- `CorgiNotch/Shared/Assets/CorgiNotch.swift`
  - add calendar icon/color entries

## Permissions / Platform Notes
- Because this app targets macOS 14+, prefer:
  - `requestFullAccessToEvents()`
- Add the matching usage string:
  - `NSCalendarsFullAccessUsageDescription`
- If reminders are added later, also add:
  - `NSRemindersFullAccessUsageDescription`

## UX Notes
- Keep the visual footprint smaller than `boring.notch`.
- `CorgiNotch` currently has a much simpler expanded layout than `boring.notch`, so the calendar should be treated as a compact companion panel, not a large multi-mode dashboard.
- Recommended width target:
  - roughly 180-220pt when shown beside now playing
- Show a strong empty state:
  - "No events today"
  - lightweight subtitle
- On permission denial, show:
  - short explanation
  - button to open Calendar privacy settings

## Suggested Phases

### Phase 1
- Add models, service, and permissions flow
- Add `.calendar` expanded item and settings shell
- Render a compact day strip + event list

### Phase 2
- Add calendar source selection UI
- Add deep linking into Calendar for events
- Improve empty/denied/loading states

### Phase 3
- Consider reminder support
- Consider richer event metadata and UI polish

## Risks
- EventKit permission behavior changed in macOS 14+, so the privacy strings must match the access method used.
- The expanded notch currently only hosts `Now Playing`; calendar width and divider behavior need careful tuning.
- `boring.notch` mixes reminders into the same manager; copying that structure directly would add complexity faster than `CorgiNotch` needs.
