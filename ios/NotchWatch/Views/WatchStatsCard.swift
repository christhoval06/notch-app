import SwiftUI

struct WatchStatsCard: View {
    let snapshot: WatchSnapshot
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("watchStats", systemImage: "chart.bar.fill")
                .font(.caption).foregroundStyle(WatchTheme.blue)
            Text(verbatim: snapshot.monthId ?? "—").font(.caption2).foregroundStyle(.secondary)
            LabeledContent("watchEntries") { Text(snapshot.entryCount ?? 0, format: .number) }
            LabeledContent("watchAverage") {
                if let rating = snapshot.averageRating { Text(rating, format: .number.precision(.fractionLength(1))) }
                else { Text(verbatim: "—") }
            }
            LabeledContent("watchProtection") {
                if let rate = snapshot.protectionRate { Text(rate, format: .percent.precision(.fractionLength(0))) }
                else { Text(verbatim: "—") }
            }
        }
        .font(.caption2).padding(12)
        .background(WatchTheme.surface, in: RoundedRectangle(cornerRadius: 16))
        .privacySensitive()
    }
}
