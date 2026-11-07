import SwiftUI

struct WatchAccessGate<Content: View>: View {
    @EnvironmentObject private var store: WatchCompanionStore
    @ViewBuilder let content: () -> Content
    var body: some View {
        if store.canCreate { content() }
        else { Text("watchOpenPhone").font(.footnote).padding() }
    }
}
