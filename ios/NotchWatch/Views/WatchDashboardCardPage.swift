import SwiftUI

struct WatchDashboardCardPage: View {
    let card: WatchDashboardCard
    let snapshot: WatchSnapshot

    var body: some View {
        Group {
            switch card {
            case .abstinence: WatchAbstinenceCard(snapshot: snapshot)
            case .level: WatchLevelCard(snapshot: snapshot)
            case .stats: WatchStatsCard(snapshot: snapshot)
            case .orgasms: WatchMonthlyTotalCard(snapshot: snapshot)
            }
        }
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
