import SwiftUI

struct WatchDashboardView: View {
    @EnvironmentObject private var store: WatchCompanionStore
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    if let snapshot = store.snapshot, snapshot.state == "active" {
                        WatchAbstinenceCard(snapshot: snapshot)
                        WatchLevelCard(snapshot: snapshot)
                        WatchStatsCard(snapshot: snapshot)
                        if let time = snapshot.generatedAtMs {
                            VStack {
                                Text("watchLastSync")
                                Text(Date(timeIntervalSince1970: Double(time) / 1000), style: .relative)
                            }.font(.caption2).foregroundStyle(.secondary)
                        }
                    } else {
                        Label("watchOpenPhone", systemImage: "iphone.and.arrow.forward")
                            .font(.footnote).padding(.vertical)
                    }
                    NavigationLink { WatchEntryForm() } label: {
                        Label("watchAddEntry", systemImage: "plus")
                    }.buttonStyle(.borderedProminent).disabled(!store.canCreate)
                    if store.canCreate && !store.entries.isEmpty {
                        NavigationLink { WatchPendingList() } label: {
                            Text("watchQueueTitle") + Text(verbatim: " (\(store.entries.count))")
                        }
                    }
                    Button("watchRefresh") { store.refresh() }
                        .font(.caption)
                }.padding(.horizontal, 6)
            }
            .background(WatchTheme.background)
            .navigationTitle("NOTCH")
            .alert("watchNotice", isPresented: Binding(
                get: { store.errorKey != nil }, set: { if !$0 { store.errorKey = nil } })) {
                Button("watchOK", role: .cancel) { store.errorKey = nil }
            } message: { Text(LocalizedStringKey(store.errorKey ?? "watchSyncUnavailable")) }
        }
    }
}
