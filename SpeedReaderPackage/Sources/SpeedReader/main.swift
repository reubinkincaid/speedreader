import SwiftUI

struct SpeedReaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800, minHeight: 600)
        }
        .commands {
            TextEditingCommands()
        }
    }
}

SpeedReaderApp.main()
