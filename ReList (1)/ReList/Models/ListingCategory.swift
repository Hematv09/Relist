import Foundation

enum ListingCategory: String, Codable, CaseIterable, Identifiable {
    case electronics = "Electronics"
    case fashion = "Fashion"
    case books = "Books"
    case furniture = "Furniture"
    case sports = "Sports"
    case others = "Others"

    var id: String { rawValue }
}
