import SwiftUI

struct WatchLevelCard: View {
    let snapshot: WatchSnapshot
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("watchCurrentLevel", systemImage: "star.fill")
                .font(.caption).foregroundStyle(WatchTheme.purple)
            Text(verbatim: snapshot.levelName ?? "—").font(.headline)
            ProgressView(value: min(1, max(0, snapshot.progress ?? 0))).tint(WatchTheme.purple)
            HStack {
                Text(snapshot.xp ?? 0, format: .number)
                Text("watchXP")
                Spacer()
                Text(snapshot.nextXp ?? 0, format: .number)
            }.font(.caption2).foregroundStyle(.secondary)
        }
        .padding(12).background(WatchTheme.surface, in: RoundedRectangle(cornerRadius: 16))
        .privacySensitive()
    }
}
