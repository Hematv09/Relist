import SwiftUI

struct AddListingView: View {
    @EnvironmentObject private var listingsViewModel: ListingsViewModel
    @StateObject private var viewModel = AddListingViewModel()

    var body: some View {
        NavigationStack {
            Form {
                Section("Item Details") {
                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Title", text: $viewModel.title)
                        fieldError(viewModel.titleError)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Price", text: $viewModel.priceText)
                            .keyboardType(.decimalPad)
                        fieldError(viewModel.priceError)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Picker("Category", selection: $viewModel.selectedCategory) {
                            Text("Select a category").tag(ListingCategory?.none)
                            ForEach(ListingCategory.allCases) { category in
                                Text(category.rawValue).tag(Optional(category))
                            }
                        }
                        fieldError(viewModel.categoryError)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Picker("Condition", selection: $viewModel.selectedCondition) {
                            Text("Select a condition").tag(ListingCondition?.none)
                            ForEach(ListingCondition.allCases) { condition in
                                Text(condition.rawValue).tag(Optional(condition))
                            }
                        }
                        fieldError(viewModel.conditionError)
                    }
                }

                Section("Seller Info") {
                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Location", text: $viewModel.location)
                        fieldError(viewModel.locationError)
                    }

                    TextField("Seller Name", text: $viewModel.sellerName)
                }

                Section("Description") {
                    VStack(alignment: .leading, spacing: 6) {
                        TextEditor(text: $viewModel.descriptionText)
                            .frame(minHeight: 120)
                        fieldError(viewModel.descriptionError)
                    }
                }

                Section {
                    Button("Submit Listing") {
                        if let newListing = viewModel.submit() {
                            listingsViewModel.addListing(newListing)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    if let submissionMessage = viewModel.submissionMessage {
                        Text(submissionMessage)
                            .font(.subheadline)
                            .foregroundStyle(.green)
                    }
                }
            }
            .navigationTitle("Add Listing")
        }
    }

    @ViewBuilder
    private func fieldError(_ message: String?) -> some View {
        if let message {
            Text(message)
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
}
