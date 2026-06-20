import Foundation

@MainActor
final class ListingsViewModel: ObservableObject {
    enum ViewState: Equatable {
        case idle
        case loading
        case loaded
        case empty
        case error(String)
    }

    enum SortOption: String, CaseIterable, Identifiable {
        case none = "None"
        case lowToHigh = "Low to High"
        case highToLow = "High to Low"

        var id: String { rawValue }
    }

    @Published private(set) var listings: [Listing] = []
    @Published private(set) var state: ViewState = .idle
    @Published var searchText: String = ""
    @Published var selectedCategory: ListingCategory?
    @Published var sortOption: SortOption = .none

    private let service: ListingService

    init(service: ListingService) {
        self.service = service
    }

    var displayedListings: [Listing] {
        var result = listings.filter { $0.isAvailable }

        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let query = searchText.lowercased()
            result = result.filter {
                $0.title.lowercased().contains(query) ||
                $0.category.rawValue.lowercased().contains(query)
            }
        }

        if let selectedCategory {
            result = result.filter { $0.category == selectedCategory }
        }

        switch sortOption {
        case .none:
            result.sort { $0.postedDate > $1.postedDate }
        case .lowToHigh:
            result.sort { $0.price < $1.price }
        case .highToLow:
            result.sort { $0.price > $1.price }
        }

        return result
    }

    func loadListings() async {
        state = .loading

        do {
            let fetchedListings = try await service.fetchListings()
            listings = fetchedListings.sorted { $0.postedDate > $1.postedDate }
            state = listings.isEmpty ? .empty : .loaded
        } catch {
            listings = []
            state = .error(error.localizedDescription)
        }
    }

    func resetFilters() {
        searchText = ""
        selectedCategory = nil
        sortOption = .none
    }

    func addListing(_ listing: Listing) {
        listings.insert(listing, at: 0)
        state = listings.isEmpty ? .empty : .loaded
    }

    func listing(withID id: UUID) -> Listing? {
        listings.first(where: { $0.id == id })
    }
}
