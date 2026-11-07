import SwiftUI

@main
struct NotchWatchApp: App {
    @StateObject private var store = WatchCompanionStore()
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            WatchDashboardView()
                .environmentObject(store)
                .tint(WatchTheme.blue)
                .onChange(of: scenePhase) { _, phase in
                    if phase == .active { store.refresh() }
                }
        }
    }
}
