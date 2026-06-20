import SwiftUI

@main
struct ReListApp: App {
    @StateObject private var listingsViewModel = ListingsViewModel(service: MockListingService())
    @StateObject private var savedListingsViewModel = SavedListingsViewModel(store: SavedListingStore())

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(listingsViewModel)
                .environmentObject(savedListingsViewModel)
        }
    }
}
