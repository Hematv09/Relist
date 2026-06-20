import XCTest
@testable import ReList

@MainActor
final class ListingsViewModelTests: XCTestCase {
    func testResetFiltersClearsSearchCategoryAndSort() {
        let viewModel = ListingsViewModel(service: MockListingService())
        viewModel.searchText = "book"
        viewModel.selectedCategory = .books
        viewModel.sortOption = .highToLow

        viewModel.resetFilters()

        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertNil(viewModel.selectedCategory)
        XCTAssertEqual(viewModel.sortOption, .none)
    }
}
