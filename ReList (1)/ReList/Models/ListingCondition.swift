import Foundation

enum ListingCondition: String, Codable, CaseIterable, Identifiable {
    case new = "New"
    case likeNew = "Like New"
    case good = "Good"
    case fair = "Fair"
    case used = "Used"

    var id: String { rawValue }
}
