import SwiftUI

@main
struct SpeedReaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .commands {
            CommandMenu("Edit") {
                Button("Undo") {}
                .keyboardShortcut("z", modifiers: .command)
                
                Button("Redo") {}
                .keyboardShortcut("z", modifiers: [.command, .shift])
                
                Divider()
                
                Button("Cut") {}
                .keyboardShortcut("x", modifiers: .command)
                
                Button("Copy") {}
                .keyboardShortcut("c", modifiers: .command)
                
                Button("Paste") {}
                .keyboardShortcut("v", modifiers: .command)
                
                Button("Paste and Match Style") {}
                .keyboardShortcut("v", modifiers: [.command, .option])
                
                Divider()
                
                Button("Select All") {}
                .keyboardShortcut("a", modifiers: .command)
            }
        }
    }
}