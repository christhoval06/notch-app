import Foundation

enum WatchDashboardCard: String, CaseIterable {
    case abstinence, level, stats, orgasms
}

enum WatchDashboardLayout {
    static let actions = "actions"
    static let defaults: [WatchDashboardCard] = [.abstinence, .level, .stats]

    static func cards(in snapshot: WatchSnapshot?) -> [WatchDashboardCard] {
        guard let snapshot, snapshot.allowsPrivateContent else { return [] }
        var seen = Set<WatchDashboardCard>()
        return (snapshot.dashboardCards ?? defaults.map(\.rawValue)).compactMap { raw in
            guard let card = WatchDashboardCard(rawValue: raw), seen.insert(card).inserted else { return nil }
            return card
        }
    }

    static func selection(_ selected: String, cards: [WatchDashboardCard]) -> String {
        if selected == actions || cards.contains(where: { $0.rawValue == selected }) { return selected }
        return cards.first?.rawValue ?? actions
    }
}

struct WatchDashboardSelection {
    var page = ""
    private var hadVisibleCards = false

    mutating func update(cards: [WatchDashboardCard]) {
        if !hadVisibleCards, let first = cards.first { page = first.rawValue }
        else { page = WatchDashboardLayout.selection(page, cards: cards) }
        hadVisibleCards = !cards.isEmpty
    }
}
