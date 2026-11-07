import SwiftUI

struct WatchMonthlyTotalCard: View {
    let snapshot: WatchSnapshot

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("watchCardOrgasms", systemImage: "heart.fill")
                .font(.caption).foregroundStyle(WatchTheme.purple)
            Text(snapshot.orgasmCount ?? 0, format: .number)
                .font(.largeTitle.monospacedDigit().bold())
                .lineLimit(1).minimumScaleFactor(0.5)
            Text(verbatim: snapshot.monthId ?? "—")
                .font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading).padding(12)
        .background(WatchTheme.surface, in: RoundedRectangle(cornerRadius: 16))
        .privacySensitive()
    }
}
