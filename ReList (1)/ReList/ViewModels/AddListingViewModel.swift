import Foundation

@MainActor
final class AddListingViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var priceText: String = ""
    @Published var selectedCategory: ListingCategory?
    @Published var selectedCondition: ListingCondition?
    @Published var location: String = ""
    @Published var sellerName: String = ""
    @Published var descriptionText: String = ""

    @Published private(set) var titleError: String?
    @Published private(set) var priceError: String?
    @Published private(set) var categoryError: String?
    @Published private(set) var conditionError: String?
    @Published private(set) var locationError: String?
    @Published private(set) var descriptionError: String?
    @Published private(set) var submissionMessage: String?

    var canSubmit: Bool {
        validationErrors().isEmpty
    }

    func submit() -> Listing? {
        clearMessages()

        let errors = validationErrors()
        apply(errors: errors)

        guard errors.isEmpty, let price = Double(priceText) else {
            return nil
        }

        let listing = Listing(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            description: descriptionText.trimmingCharacters(in: .whitespacesAndNewlines),
            price: price,
            category: selectedCategory ?? .others,
            condition: selectedCondition ?? .used,
            location: location.trimmingCharacters(in: .whitespacesAndNewlines),
            sellerName: sellerName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "You" : sellerName.trimmingCharacters(in: .whitespacesAndNewlines),
            postedDate: Date(),
            imageName: selectedCategory?.defaultSymbol ?? "shippingbox",
            isAvailable: true
        )

        resetForm()
        submissionMessage = "Listing added successfully."
        return listing
    }

    func resetForm() {
        title = ""
        priceText = ""
        selectedCategory = nil
        selectedCondition = nil
        location = ""
        sellerName = ""
        descriptionText = ""

        titleError = nil
        priceError = nil
        categoryError = nil
        conditionError = nil
        locationError = nil
        descriptionError = nil
    }

    private func validationErrors() -> [Field: String] {
        var errors: [Field: String] = [:]

        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors[.title] = "Title is required."
        }

        if let price = Double(priceText), price > 0 {
        } else {
            errors[.price] = "Enter a price greater than 0."
        }

        if selectedCategory == nil {
            errors[.category] = "Select a category."
        }

        if selectedCondition == nil {
            errors[.condition] = "Select a condition."
        }

        if location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errors[.location] = "Location is required."
        }

        if descriptionText.trimmingCharacters(in: .whitespacesAndNewlines).count < 20 {
            errors[.description] = "Description must be at least 20 characters."
        }

        return errors
    }

    private func apply(errors: [Field: String]) {
        titleError = errors[.title]
        priceError = errors[.price]
        categoryError = errors[.category]
        conditionError = errors[.condition]
        locationError = errors[.location]
        descriptionError = errors[.description]
    }

    private func clearMessages() {
        submissionMessage = nil
    }

    enum Field {
        case title
        case price
        case category
        case condition
        case location
        case description
    }
}

private extension ListingCategory {
    var defaultSymbol: String {
        switch self {
        case .electronics:
            return "desktopcomputer"
        case .fashion:
            return "tshirt"
        case .books:
            return "book"
        case .furniture:
            return "sofa"
        case .sports:
            return "figure.run"
        case .others:
            return "shippingbox"
        }
    }
}
