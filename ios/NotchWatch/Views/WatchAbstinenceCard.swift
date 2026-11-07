import SwiftUI

struct WatchAbstinenceCard: View {
    let snapshot: WatchSnapshot
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("watchAbstinence", systemImage: "hourglass")
                .font(.caption).foregroundStyle(WatchTheme.green)
            TimelineView(.periodic(from: .now, by: 60)) { context in
                let start = snapshot.abstinenceReferenceMs.map { Date(timeIntervalSince1970: Double($0) / 1000) }
                let minutes = max(0, Int(context.date.timeIntervalSince(start ?? context.date) / 60))
                Text(String(format: NSLocalizedString("watchDuration", comment: ""),
                    Int64(minutes / 1440), Int64(minutes / 60 % 24), Int64(minutes % 60)))
                    .font(.title3.monospacedDigit().bold()).minimumScaleFactor(0.6).lineLimit(1)
            }
            if snapshot.zeroState == true { Text("watchNoHistory").font(.caption2).foregroundStyle(.secondary) }
        }
        .frame(maxWidth: .infinity, alignment: .leading).padding(12)
        .background(WatchTheme.surface, in: RoundedRectangle(cornerRadius: 16))
        .privacySensitive()
    }
}
