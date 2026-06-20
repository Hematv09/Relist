import SwiftUI

struct ListingCardView: View {
    let listing: Listing
    let isSaved: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.secondarySystemBackground))

                Image(systemName: listing.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(18)
                    .foregroundStyle(.tint)
            }
            .frame(width: 92, height: 92)

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    Text(listing.title)
                        .font(.headline)
                        .lineLimit(2)

                    Spacer()

                    if isSaved {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                    }
                }

                Text(PriceFormatter.string(from: listing.price))
                    .font(.title3.weight(.bold))

                Text("\(listing.category.rawValue) • \(listing.condition.rawValue)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("\(listing.location) • \(listing.sellerName)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Text(listing.postedDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color(.separator).opacity(0.25), lineWidth: 1)
        )
    }
}
