import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }

            SavedListingsView()
                .tabItem {
                    Label("Saved", systemImage: "heart")
                }

            AddListingView()
                .tabItem {
                    Label("Add Listing", systemImage: "plus.circle")
                }
        }
    }
}
