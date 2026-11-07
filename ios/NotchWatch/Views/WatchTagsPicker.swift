import SwiftUI

struct WatchTagsPicker: View {
    @Binding var selected: [String]
    let options: [WatchTagOption]

    var body: some View {
        WatchAccessGate {
            List {
                if options.isEmpty { Text("watchOptionsNeedSync").foregroundStyle(.secondary) }
                ForEach(options) { option in
                    Toggle(isOn: Binding(
                        get: { selected.contains(option.key) },
                        set: { enabled in
                            selected.removeAll { $0 == option.key }
                            if enabled { selected.append(option.key) }
                            selected.sort()
                        }
                    )) { Text(verbatim: option.label) }
                }
            }
        }
        .navigationTitle("watchTags")
        .privacySensitive()
    }
}
