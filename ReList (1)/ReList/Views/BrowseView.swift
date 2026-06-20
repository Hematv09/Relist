import SwiftUI

struct BrowseView: View {
    @EnvironmentObject private var listingsViewModel: ListingsViewModel
    @EnvironmentObject private var savedListingsViewModel: SavedListingsViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch listingsViewModel.state {
                case .idle, .loading:
                    ProgressView("Loading listings...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .error(let message):
                    ErrorStateView(message: message) {
                        Task { await listingsViewModel.loadListings() }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .empty:
                    EmptyStateView(
                        title: "No Listings Yet",
                        message: "Try again later or add the first listing.",
                        systemImage: "tray"
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .loaded:
                    contentView
                }
            }
            .navigationTitle("ReList")
            .task {
                guard listingsViewModel.state == .idle else { return }
                await listingsViewModel.loadListings()
            }
        }
    }

    private var contentView: some View {
        VStack(spacing: 12) {
            filterSection

            if listingsViewModel.displayedListings.isEmpty {
                Spacer()
                EmptyStateView(
                    title: "No Matching Listings",
                    message: "Change your search, filters, or sorting to see more items.",
                    systemImage: "magnifyingglass"
                )
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(listingsViewModel.displayedListings) { listing in
                            NavigationLink {
                                ListingDetailView(listing: listing)
                            } label: {
                                ListingCardView(
                                    listing: listing,
                                    isSaved: savedListingsViewModel.isSaved(listing.id)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    private var filterSection: some View {
        VStack(spacing: 12) {
            TextField("Search by title or category", text: $listingsViewModel.searchText)
                .textFieldStyle(.roundedBorder)

            HStack {
                Picker("Category", selection: $listingsViewModel.selectedCategory) {
                    Text("All Categories").tag(ListingCategory?.none)
                    ForEach(ListingCategory.allCases) { category in
                        Text(category.rawValue).tag(Optional(category))
                    }
                }
                .pickerStyle(.menu)

                Picker("Sort", selection: $listingsViewModel.sortOption) {
                    ForEach(ListingsViewModel.SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.menu)
            }

            Button("Reset Filters") {
                listingsViewModel.resetFilters()
            }
            .font(.subheadline.weight(.semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.top, 12)
    }
}
