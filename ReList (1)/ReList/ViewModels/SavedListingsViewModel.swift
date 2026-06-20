import Foundation

@MainActor
final class SavedListingsViewModel: ObservableObject {
    @Published private(set) var savedIDs: Set<UUID> = []

    private let store: SavedListingStoring

    init(store: SavedListingStoring) {
        self.store = store
        self.savedIDs = store.fetchSavedIDs()
    }

    func isSaved(_ id: UUID) -> Bool {
        savedIDs.contains(id)
    }

    func toggleSaved(for id: UUID) {
        if savedIDs.contains(id) {
            savedIDs.remove(id)
        } else {
            savedIDs.insert(id)
        }
        persist()
    }

    func remove(_ id: UUID) {
        savedIDs.remove(id)
        persist()
    }

    func savedListings(from listings: [Listing]) -> [Listing] {
        listings
            .filter { savedIDs.contains($0.id) }
            .sorted { $0.postedDate > $1.postedDate }
    }

    private func persist() {
        store.save(ids: savedIDs)
    }
}
