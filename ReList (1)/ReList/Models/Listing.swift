import Foundation

struct Listing: Codable, Identifiable, Equatable {
    let id: UUID
    let title: String
    let description: String
    let price: Double
    let category: ListingCategory
    let condition: ListingCondition
    let location: String
    let sellerName: String
    let postedDate: Date
    let imageName: String
    let isAvailable: Bool

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        price: Double,
        category: ListingCategory,
        condition: ListingCondition,
        location: String,
        sellerName: String,
        postedDate: Date = Date(),
        imageName: String,
        isAvailable: Bool = true
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.category = category
        self.condition = condition
        self.location = location
        self.sellerName = sellerName
        self.postedDate = postedDate
        self.imageName = imageName
        self.isAvailable = isAvailable
    }
}
