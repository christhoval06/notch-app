import Foundation
var snapshot = WatchSnapshot(schemaVersion: 1, kind: "snapshot", generation: "g", revision: 1, state: "active")
assert(WatchDashboardLayout.cards(in: snapshot) == [.abstinence, .level, .stats])
snapshot.dashboardCards = ["stats", "unknown", "orgasms", "stats"]
assert(WatchDashboardLayout.cards(in: snapshot) == [.stats, .orgasms])
assert(WatchDashboardLayout.selection("level", cards: [.stats, .orgasms]) == "stats")
assert(WatchDashboardLayout.selection("orgasms", cards: [.stats, .orgasms]) == "orgasms")
snapshot.dashboardCards = []
assert(WatchDashboardLayout.cards(in: snapshot).isEmpty)
assert(WatchDashboardLayout.selection("level", cards: []) == "actions")
assert(WatchDashboardLayout.selection("actions", cards: [.stats]) == "actions")
let disabled = WatchSnapshot(schemaVersion: 1, kind: "snapshot", generation: "g", revision: 2, state: "disabled")
assert(WatchDashboardLayout.cards(in: disabled).isEmpty)
assert(WatchDashboardLayout.cards(in: nil).isEmpty)
print("Passed Watch page defaults, ordering, unknown IDs, empty selection, fallback and access checks")

var restored = WatchDashboardSelection()
restored.update(cards: [])
assert(restored.page == "actions")
restored.update(cards: [.stats, .level])
assert(restored.page == "stats", "First active snapshot must open the first enabled card")
restored.page = "actions"
restored.update(cards: [.level, .stats])
assert(restored.page == "actions", "Ordinary active changes preserve intentional action selection")
restored.update(cards: [])
restored.update(cards: [.level])
assert(restored.page == "level", "Restoring private content opens the first card")
var cached = WatchDashboardSelection()
cached.update(cards: [.stats, .level, .abstinence])
assert(cached.page == "stats", "Cached order determines the initial page")
cached.page = "abstinence"
cached.update(cards: [.stats, .level])
assert(cached.page == "stats", "Removing the selected card chooses a valid page")
print("Passed initial, restored, reordered and removed-page transitions")
