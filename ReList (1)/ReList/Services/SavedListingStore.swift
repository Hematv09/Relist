import Foundation

protocol SavedListingStoring {
    func fetchSavedIDs() -> Set<UUID>
    func save(ids: Set<UUID>)
}

final class SavedListingStore: SavedListingStoring {
    private let defaults: UserDefaults
    private let key = "saved_listing_ids"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func fetchSavedIDs() -> Set<UUID> {
        let savedStrings = defaults.stringArray(forKey: key) ?? []
        let ids = savedStrings.compactMap(UUID.init(uuidString:))
        return Set(ids)
    }

    func save(ids: Set<UUID>) {
        let strings = ids.map(\.uuidString).sorted()
        defaults.set(strings, forKey: key)
    }
}
