import SwiftUI

struct SavedListingsView: View {
    @EnvironmentObject private var listingsViewModel: ListingsViewModel
    @EnvironmentObject private var savedListingsViewModel: SavedListingsViewModel

    private var savedListings: [Listing] {
        savedListingsViewModel.savedListings(from: listingsViewModel.listings)
    }

    var body: some View {
        NavigationStack {
            Group {
                if savedListings.isEmpty {
                    EmptyStateView(
                        title: "No Saved Listings",
                        message: "Tap the heart icon on an item to save it for later.",
                        systemImage: "heart"
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(savedListings) { listing in
                            NavigationLink {
                                ListingDetailView(listing: listing)
                            } label: {
                                ListingCardView(listing: listing, isSaved: true)
                                    .padding(.vertical, 4)
                            }
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .listRowSeparator(.hidden)
                            .swipeActions {
                                Button(role: .destructive) {
                                    savedListingsViewModel.remove(listing.id)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Saved")
        }
    }
}
