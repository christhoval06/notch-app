import SwiftUI

struct WatchActionsPage: View {
    @EnvironmentObject private var store: WatchCompanionStore
    var showCardHint = false

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                if !store.canCreate {
                    Label("watchOpenPhone", systemImage: "iphone.and.arrow.forward")
                        .font(.footnote).padding(.vertical)
                } else if showCardHint {
                    Text("watchChooseCards").font(.footnote).foregroundStyle(.secondary)
                }
                NavigationLink { WatchEntryForm() } label: {
                    Label("watchAddEntry", systemImage: "plus")
                }.buttonStyle(.borderedProminent).disabled(!store.canCreate)
                if store.canCreate && !store.entries.isEmpty {
                    NavigationLink { WatchPendingList() } label: {
                        Text("watchQueueTitle") + Text(verbatim: " (\(store.entries.count))")
                    }
                }
                Button("watchRefresh") { store.refresh() }.font(.caption)
                if store.canCreate, let time = store.snapshot?.generatedAtMs {
                    VStack {
                        Text("watchLastSync")
                        Text(Date(timeIntervalSince1970: Double(time) / 1000), style: .relative)
                    }.font(.caption2).foregroundStyle(.secondary)
                }
            }.padding(.horizontal, 6)
        }
    }
}
