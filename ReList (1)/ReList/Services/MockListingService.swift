import Foundation

enum MockListingError: LocalizedError {
    case failedToLoad

    var errorDescription: String? {
        switch self {
        case .failedToLoad:
            return "We couldn't load listings right now. Please try again."
        }
    }
}

struct MockListingService: ListingService {
    var shouldFail: Bool = false
    var delayNanoseconds: UInt64 = 700_000_000

    func fetchListings() async throws -> [Listing] {
        try await Task.sleep(nanoseconds: delayNanoseconds)

        if shouldFail {
            throw MockListingError.failedToLoad
        }

        return try SampleDataLoader.loadListings()
    }
}
