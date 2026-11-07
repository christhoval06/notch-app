import SwiftUI

struct WatchPartnerPicker: View {
    @Binding var partner: String
    let names: [String]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        WatchAccessGate {
            Form {
                TextField("watchPartner", text: $partner)
                    .onChange(of: partner) { _, value in
                        var limited = value
                        while limited.utf16.count > 80 { limited.removeLast() }
                        if limited != value { partner = limited }
                    }
                Section("watchExistingPartners") {
                    if names.isEmpty { Text("watchNoPartners").foregroundStyle(.secondary) }
                    ForEach(names, id: \.self) { name in
                        Button {
                            partner = name
                            dismiss()
                        } label: {
                            Text(verbatim: name).frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
        }
        .navigationTitle("watchPartner")
        .privacySensitive()
    }
}
