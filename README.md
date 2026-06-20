# ReList - Secondhand Marketplace iOS App

## Overview
ReList is an intermediate-level SwiftUI portfolio project that recreates a secondhand marketplace experience on iOS. Users can browse listings, search and filter items, view details, save favorites, and add new listings locally.

## Why I Built It
I built ReList to practice building a realistic SwiftUI app with clean architecture, state management, async data loading, local persistence, and form validation. The goal was to create a project that feels production-inspired while staying appropriate for an iOS internship portfolio.

## Features
- Browse secondhand listings in a marketplace-style card layout
- Load data through a service layer using async/await
- Handle loading, error, empty, and success states
- Search listings by title or category
- Filter listings by category
- Sort listings by price
- Save and remove favorite listings with local persistence
- View full listing details
- Add a new listing through a validated SwiftUI form
- Use reusable views and MVVM structure for maintainability

## Tech Stack
- Swift
- SwiftUI
- Xcode
- MVVM architecture
- Async/await
- Codable
- Local JSON mock data
- UserDefaults persistence

## Screenshots
Add screenshots here after running the project:

- Browse screen
- Listing detail screen
- Saved listings screen
- Add listing form

## Folder Structure
```text
ReList/
├── ReListApp.swift
├── Models/
│   ├── Listing.swift
│   ├── ListingCategory.swift
│   └── ListingCondition.swift
├── Views/
│   ├── RootTabView.swift
│   ├── BrowseView.swift
│   ├── ListingCardView.swift
│   ├── ListingDetailView.swift
│   ├── SavedListingsView.swift
│   ├── AddListingView.swift
│   ├── EmptyStateView.swift
│   └── ErrorStateView.swift
├── ViewModels/
│   ├── ListingsViewModel.swift
│   ├── SavedListingsViewModel.swift
│   └── AddListingViewModel.swift
├── Services/
│   ├── ListingService.swift
│   ├── MockListingService.swift
│   └── SavedListingStore.swift
├── Utilities/
│   ├── PriceFormatter.swift
│   └── SampleDataLoader.swift
└── Resources/
    └── listings.json
```

## Architecture
This app uses MVVM to separate UI, business logic, and data access:

- **Views** render the interface and forward user actions.
- **ViewModels** manage screen state, filtering, validation, and saved-item logic.
- **Services** abstract data loading and persistence.
- **Models** represent app data using `Codable` and enums.
- **Utilities** contain small shared helpers like formatting and JSON loading.

This keeps SwiftUI views lightweight and makes logic easier to test.

## What I Learned
- How to structure a SwiftUI app using MVVM
- How to load local mock data asynchronously
- How to manage app state across tabs with `@StateObject` and `@EnvironmentObject`
- How to persist lightweight data using `UserDefaults`
- How to validate forms cleanly in a ViewModel
- How to build reusable SwiftUI components for a more maintainable project

## Future Improvements
- Add image selection for user-created listings
- Support edit and delete for user-created listings
- Add seller profile pages and chat UI
- Persist custom listings across app launches
- Replace local JSON with a real backend or Firebase
- Add unit tests for filtering and validation logic

## How to Run the Project
1. Open Xcode.
2. Create a new **iOS App** project named **ReList** using **SwiftUI**.
3. Replace the generated files with the files in this project.
4. Add `Resources/listings.json` to the app target and make sure it is copied into the bundle.
5. Build and run on the iOS Simulator.

## Resume Bullets
- Built a SwiftUI marketplace app using MVVM, with browse, detail, saved, and listing-creation flows structured across reusable views and view models.
- Implemented async data loading through a mock service layer with loading, empty, success, and error states to model production-style UI behavior.
- Designed search, category filtering, and price sorting in the ViewModel using computed properties to keep business logic out of SwiftUI views.
- Persisted favorite listings with `UserDefaults`, enabling saved-item state to remain consistent across app launches.
- Created a validated add-listing form with inline error messaging and local state updates, allowing newly submitted items to appear immediately in the browse feed.
