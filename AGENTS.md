# AGENTS.md - SpeedReader Development Guide

This document provides guidelines for AI agents working on the SpeedReader codebase.

## Build Commands

### Swift Package Manager (Recommended)
```bash
cd /Users/studio/Documents/GitHub/speedreader/SpeedReaderPackage
swift build              # Debug build
swift build --release    # Release build
swift run                # Build and run executable
```

### Xcode Project
```bash
open /Users/studio/Documents/GitHub/speedreader/SpeedReader.xcodeproj
# Then press Cmd+R to build and run
```

### Simple Command-Line Version
```bash
swift /Users/studio/Documents/GitHub/speedreader/SimpleSpeedReader/main.swift
```

## Testing

Run all tests:
```bash
swift /Users/studio/Docments/GitHub/speedreader/test_speedreader.swift
```

This test file verifies:
- ORP index calculation for word lengths 1-3, 4-7, and 8+
- Text processing with punctuation handling
- Speed timing calculations (WPM to seconds per word)

## Code Style Guidelines

### Naming Conventions
- **Types/Classes**: PascalCase (`ContentView`, `RSVPView`, `SpeedReaderApp`)
- **Variables/Constants**: camelCase (`textInput`, `isReading`, `currentWordIndex`)
- **Private Members**: Prefix with underscore for clarity (`_timer`, `_speed`)
- **Functions**: camelCase with verb-first naming (`startReading()`, `calculateORPIndex()`)
- **Acronyms**: Keep uppercase in types, lowercase elsewhere (`RSVP`, `URL`)

### Imports
- Group imports at the top of files
- Only import what is used (`import SwiftUI`, not `import AppKit`)
- No wildcard imports

### Formatting
- Use 4 spaces for indentation (not tabs)
- No blank lines between import and first declaration
- Max line length: 120 characters
- Wrap long function calls with one parameter per line when exceeding 120 chars
- Use trailing commas in arrays/dictionaries when spanning multiple lines

### Types and Type Safety
- Prefer explicit types for properties and function signatures
- Use `let` by default, `var` only when mutation is required
- Avoid `Any` or `as?` type casts when possible
- Use optional chaining (`?.`) and nil-coalescing (`??`) instead of forced unwrapping
- Annotate closure parameters explicitly in function signatures

### Error Handling
- Use `guard` for early exits with clear error messages
- Validate inputs at function entry with `guard` statements
- Propagate errors with `throws` when appropriate
- Avoid silent failures; log or show user feedback
- Timer invalidation should use optional chaining (`timer?.invalidate()`)

### SwiftUI Best Practices
- Use `@State` for view-local state, `@ObservedObject` for external state
- Keep views small and focused; extract subviews when body exceeds 50 lines
- Use `.disabled()` for UX feedback rather than hiding controls
- Apply consistent padding/spacing: `.padding(8)` or `.padding(.horizontal, 16)`
- Use system fonts with explicit sizes: `.font(.system(size: 14))`
- Avoid magic numbers; extract to named constants or computed properties

### Documentation
- Document public APIs with triple-slash comments
- Explain "why" not "what" in comments
- Document ORP algorithm assumptions and edge cases
- Keep comments brief and update them when code changes

### Performance
- Handle large texts (>10K chars) with chunked processing
- Limit array operations in tight loops
- Invalidate timers on view disappearance (`onDisappear`)
- Break processing loops with early exit conditions

## Project Structure

```
speedreader/
├── SpeedReaderPackage/
│   ├── Sources/SpeedReader/     # Main package source
│   ├── Package.swift            # SPM manifest
│   └── .build/                  # Build artifacts
├── SimpleSpeedReader/           # CLI version for testing
├── SpeedReaderApp.swift         # App entry point
├── ContentView.swift            # Main UI
├── RSVPView.swift               # RSVP display component
├── test_speedreader.swift       # Test suite
└── SpeedReader.xcodeproj/       # Xcode project
```

## Common Tasks

### Add a New Feature
1. Create new Swift files in `Sources/SpeedReader/` for SPM builds
2. Add files to Xcode project via File > Add Files
3. Update `Package.swift` if adding new targets
4. Run `swift test_speedreader.swift` to verify no regressions

### Debug ORP Calculation
Run the test script and verify output matches expected ORP indices:
- 1-3 char words: ORP at index 0
- 4-7 char words: ORP at length/2
- 8+ char words: ORP at max(2, length/2 - 1)

### Clean Build
```bash
cd SpeedReaderPackage && swift package clean
# Or in Xcode: Product > Clean Build Folder
```

## macOS Version Requirements

- **Minimum**: macOS 13.0 (Ventura)
- **Swift**: 5.7+
- **Xcode**: 14.0+
