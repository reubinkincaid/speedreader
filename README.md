# SpeedReader - macOS Speed Reading App

A professional macOS application for speed reading using RSVP (Rapid Serial Visual Presentation) with ORP (Optimal Recognition Point) highlighting technique.

## Features

### ✅ Core Functionality
- **RSVP Display**: Words appear in fixed position to eliminate eye movement
- **ORP Highlighting**: Optimal Recognition Point highlighted in **red** for maximum reading efficiency
- **Adjustable Speed**: 100-1000 WPM with real-time control
- **Large Text Support**: Efficient processing of large text inputs (>10,000 characters)

### 🎛️ User Controls
- **Start/Stop/Pause** reading sessions
- **Progress Tracking**: Current word count and total words
- **Speed Slider**: Visual feedback for WPM adjustment
- **Text Editor**: Paste or type content for reading

### 🎯 ORP Algorithm
The app uses an intelligent ORP calculation:
- **Short words (1-3 chars)**: First character highlighted
- **Medium words (4-7 chars)**: Middle character highlighted  
- **Long words (8+ chars)**: Slightly before middle (accounts for word prefixes)

## Technical Details

### Architecture
- **Platform**: Native macOS app using SwiftUI
- **Language**: Swift 5
- **Minimum OS**: macOS 12.0+
- **Build System**: Xcode project included

### Performance
- **Memory Efficient**: Handles large texts with chunked processing
- **Responsive UI**: Smooth animations and transitions
- **Precise Timing**: Accurate word presentation timing

## Installation & Usage

### Building the App
1. Open `SpeedReader.xcodeproj` in Xcode
2. Select the target device (Mac)
3. Build and run (⌘R)

### Using the App
1. **Paste or type** text into the editor
2. **Adjust speed** using the slider (100-1000 WPM)
3. **Click "Start Reading"** to begin the RSVP session
4. **Use Pause/Stop** controls to manage the reading session
5. **Monitor progress** with the word counter

## Code Structure

```
SpeedReader/
├── SpeedReaderApp.swift          # Main app entry point
├── ContentView.swift             # Main UI and reading controls
├── RSVPView.swift                # RSVP display with ORP highlighting
├── Assets.xcassets/              # App assets and icons
└── SpeedReader.xcodeproj/        # Xcode project configuration
```

## Testing

Run the included test script to verify core functionality:

```bash
swift test_speedreader.swift
```

This tests:
- ORP calculation for various word lengths
- Text processing and punctuation handling
- Speed timing calculations

## Future Enhancements

Potential features for future versions:
- **Bookmarking**: Save reading positions
- **Themes**: Dark mode and custom colors
- **Statistics**: Reading speed analytics
- **File Import**: Load text from files
- **Voice Feedback**: Optional audio cues

## License

MIT License - Free for personal and commercial use.

---

**SpeedReader** - Read faster, comprehend better, retain more!