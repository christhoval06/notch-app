import SwiftUI

struct WatchEntryForm: View {
    @EnvironmentObject private var store: WatchCompanionStore
    @Environment(\.dismiss) private var dismiss
    @State private var draft = WatchEntryDraft()
    @State private var protection = 0
    var body: some View {
        WatchAccessGate {
        Form {
            TextField("watchPartner", text: $draft.partner)
                .onChange(of: draft.partner) { _, value in
                    if value.utf16.count > 80 { draft.partner = String(value.prefix(80)) }
                }
            Picker("watchRating", selection: $draft.rating) {
                ForEach(1...10, id: \.self) { Text($0, format: .number).tag($0) }
            }
            Picker("watchOrgasms", selection: $draft.orgasmCount) {
                ForEach(0...99, id: \.self) { Text($0, format: .number).tag($0) }
            }
            Picker("watchProtection", selection: $protection) {
                Text("watchChooseProtection").tag(0)
                Text("watchYes").tag(1)
                Text("watchNo").tag(2)
            }
            Text("watchPendingExplanation").font(.caption2).foregroundStyle(.secondary)
            Button("watchSave") {
                draft.protection = protection == 0 ? nil : protection == 1
                if store.submit(draft) { dismiss() }
            }.disabled(store.isSaving || protection == 0 || draft.partner.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        }
        .navigationTitle("watchAddEntry")
        .privacySensitive()
    }
}
