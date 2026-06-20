import Foundation

enum SampleDataLoader {
    static func loadListings() throws -> [Listing] {
        guard let url = Bundle.main.url(forResource: "listings", withExtension: "json") else {
            throw SampleDataLoaderError.fileNotFound
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([Listing].self, from: data)
    }
}

enum SampleDataLoaderError: LocalizedError {
    case fileNotFound

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "The sample listings file could not be found."
        }
    }
}
