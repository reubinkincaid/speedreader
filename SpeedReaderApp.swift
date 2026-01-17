import SwiftUI

@main
struct SpeedReaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowToolbarStyle(.unified)
        .windowResizability(.contentSize)
        .commands {
            TextEditingCommands()
        }
    }
}