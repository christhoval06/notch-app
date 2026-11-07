import SwiftUI

struct WatchDashboardView: View {
    @EnvironmentObject private var store: WatchCompanionStore
    @State private var selection = WatchDashboardSelection()
    private var cards: [WatchDashboardCard] { WatchDashboardLayout.cards(in: store.snapshot) }

    var body: some View {
        NavigationStack {
            Group {
                if let snapshot = store.snapshot, snapshot.allowsPrivateContent {
                    TabView(selection: $selection.page) {
                        ForEach(cards, id: \.self) { card in
                            WatchDashboardCardPage(card: card, snapshot: snapshot)
                                .tag(card.rawValue)
                        }
                        WatchActionsPage(showCardHint: cards.isEmpty)
                            .tag(WatchDashboardLayout.actions)
                    }.tabViewStyle(.verticalPage)
                } else { WatchActionsPage() }
            }
            .background(WatchTheme.background)
            .navigationTitle("NOTCH")
            .onChange(of: cards, initial: true) { _, values in
                selection.update(cards: values)
            }
            .toolbar {
                if store.canCreate {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink { WatchEntryForm() } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(WatchTheme.onAccent)
                                .accessibilityLabel(Text("watchAddEntry"))
                        }
                    }
                }
            }
            .alert("watchNotice", isPresented: Binding(
                get: { store.errorKey != nil }, set: { if !$0 { store.errorKey = nil } })) {
                Button("watchOK", role: .cancel) { store.errorKey = nil }
            } message: { Text(LocalizedStringKey(store.errorKey ?? "watchSyncUnavailable")) }
        }
    }
}
