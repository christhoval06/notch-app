import SwiftUI

struct WatchPendingList: View {
    @EnvironmentObject private var store: WatchCompanionStore
    var body: some View {
        WatchAccessGate {
        List {
            ForEach(store.entries) { command in
                VStack(alignment: .leading, spacing: 6) {
                    Text(verbatim: command.partnerLabel).font(.headline)
                    if let reason = store.rejections[command.id] {
                        Text(LocalizedStringKey(reasonKey(reason))).font(.caption2)
                        Button("watchDiscard", role: .destructive) { store.discard(command.id) }
                    } else {
                        Label("watchPending", systemImage: "clock").font(.caption2)
                    }
                }
            }
        }
        }.navigationTitle("watchQueueTitle").privacySensitive()
    }
    private func reasonKey(_ reason: String) -> String {
        switch reason {
        case "reset": return "watchResetRejected"
        case "limit_reached": return "watchLimitRejected"
        case "future_time": return "watchTimeRejected"
        default: return "watchInvalidEntry"
        }
    }
}
