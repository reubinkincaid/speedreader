import SwiftUI
import AppKit

struct SpeedReaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowToolbarStyle(.unified)
        .commands {
            TextEditingCommands()
        }
    }
}

SpeedReaderApp.main()