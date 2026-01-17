import SwiftUI
import AppKit

struct SpeedReaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .undoRedo) {
                Button("Undo") {}
                .keyboardShortcut("z", modifiers: .command)
                
                Button("Redo") {}
                .keyboardShortcut("z", modifiers: [.command, .shift])
            }
            CommandGroup(replacing: .pasteboard) {
                Button("Cut") {}
                .keyboardShortcut("x", modifiers: .command)
                
                Button("Copy") {}
                .keyboardShortcut("c", modifiers: .command)
                
                Button("Paste") {}
                .keyboardShortcut("v", modifiers: .command)
                
                Divider()
                
                Button("Select All") {}
                .keyboardShortcut("a", modifiers: .command)
            }
        }
    }
}

SpeedReaderApp.main()