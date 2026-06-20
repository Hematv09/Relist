import SwiftUI

struct ListingDetailView: View {
    let listing: Listing

    @EnvironmentObject private var savedListingsViewModel: SavedListingsViewModel
    @State private var showContactAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerImage

                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(listing.title)
                                .font(.title2.weight(.bold))

                            Text(PriceFormatter.string(from: listing.price))
                                .font(.title3.weight(.semibold))
                        }

                        Spacer()

                        Button {
                            savedListingsViewModel.toggleSaved(for: listing.id)
                        } label: {
                            Label(
                                savedListingsViewModel.isSaved(listing.id) ? "Saved" : "Save",
                                systemImage: savedListingsViewModel.isSaved(listing.id) ? "heart.fill" : "heart"
                            )
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(savedListingsViewModel.isSaved(listing.id) ? .red : .accentColor)
                    }

                    infoRow(title: "Category", value: listing.category.rawValue)
                    infoRow(title: "Condition", value: listing.condition.rawValue)
                    infoRow(title: "Location", value: listing.location)
                    infoRow(title: "Seller", value: listing.sellerName)
                    infoRow(title: "Posted", value: listing.postedDate.formatted(date: .abbreviated, time: .omitted))

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)

                        Text(listing.description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }

                    Button("Contact Seller") {
                        showContactAlert = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 8)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Seller Contact", isPresented: $showContactAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("This demo would start a chat with \(listing.sellerName).")
        }
    }

    private var headerImage: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.secondarySystemBackground))

            Image(systemName: listing.imageName)
                .resizable()
                .scaledToFit()
                .padding(40)
                .foregroundStyle(.tint)
        }
        .frame(height: 260)
        .padding(.horizontal)
        .padding(.top)
    }

    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
    }
}
