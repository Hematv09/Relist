import Foundation

protocol ListingService {
    func fetchListings() async throws -> [Listing]
}
