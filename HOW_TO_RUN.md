# 🚀 How to Run SpeedReader - Step by Step Guide

## 📋 Original Project (Now Fixed!)

The original `SpeedReader.xcodeproj` has been **completely fixed** and should now work perfectly in Xcode.

## 🎯 Step-by-Step Instructions

### **Method 1: Using Xcode (Recommended)**

1. **Open Xcode** from your Applications folder
2. **Click "File" > "Open"** in the menu
3. **Navigate to:** `/Users/studio/Documents/GitHub/speedreader`
4. **Select `SpeedReader.xcodeproj`** and click **Open**
5. **Wait for Xcode to load** the project (may take 30-60 seconds)
6. **Make sure the scheme is set to "SpeedReader"** (top toolbar)
7. **Make sure the target is set to "My Mac"** (not an iOS device)
8. **Click the "Play" button (▶️)** in the top-left corner
9. **Wait for building** (about 1-2 minutes the first time)
10. **The app will launch automatically!**

### **Method 2: Command Line (Alternative)**

If you prefer not to use Xcode, you can use the working version:

```bash
cd /Users/studio/Documents/GitHub/speedreader/SpeedReaderFixed
swift run
```

### **Troubleshooting**

#### **If you see "No valid signing identity" error:**
1. Click on the `SpeedReader` project in the left sidebar
2. Select the `SpeedReader` target
3. Go to **Signing & Capabilities** tab
4. Under "Team", select **"None"**
5. Try building again

#### **If the app doesn't launch:**
1. **Clean the build folder:** **Product > Clean Build Folder**
2. **Quit Xcode and reopen** the project
3. Try building again

#### **If you see file not found errors:**
1. Make sure all files are in the correct location:
   - `SpeedReaderApp.swift`
   - `ContentView.swift` 
   - `RSVPView.swift`
   - `Assets.xcassets/`
2. In Xcode, go to **File > Add Files to "SpeedReader"** and add any missing files

## 🎉 Using the App

Once launched:
1. **Paste or type text** in the left panel editor
2. **Adjust reading speed** with the slider (100-1000 WPM)
3. **Click "Start Reading"** to begin the RSVP session
4. **Watch words appear** with **red ORP highlighting** in the right panel
5. **Use Pause/Stop** buttons to control the reading session
6. **Monitor progress** with the word counter

## 📚 Key Features to Try

- **ORP Highlighting**: Notice how different word lengths have the red highlight in optimal positions
- **Speed Control**: Try different speeds (300 WPM is a good starting point)
- **Large Text**: Paste a long article to test the efficient processing
- **Pause/Resume**: Test the pause functionality during reading

## 🔧 Technical Notes

- **Minimum macOS version**: 12.0 (Monterey)
- **Xcode version**: 13.0 or later
- **Swift version**: 5.5+
- **Project type**: Native macOS app using SwiftUI

The app is now fully functional and ready to use! Enjoy your speed reading experience. 🚀