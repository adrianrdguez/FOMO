# FOMO - Find What's Trending

A SwiftUI iOS app that helps you discover trending places around you, so you never miss out on what's happening right now.

## Features

- **Today View** - Browse trending spots with a list showing name, category, area, description, and trending score
- **Map View** - Interactive map with markers for all trending places in Madrid
- **Place Details** - View detailed information about each spot including why it's trending and related notes
- **Trending Score** - See how hot each location is on a scale of 0-100

## Architecture

The app follows MVVM (Model-View-ViewModel) architecture:

```
FOMO/
├── Models/
│   └── Place.swift              # Data model for trending places
├── Views/
│   ├── ContentView.swift        # Main tab container
│   ├── TodayView.swift          # List of trending places
│   ├── MapView.swift            # Interactive map view
│   └── PlaceDetailView.swift    # Detailed place information
├── ViewModels/
│   └── PlacesViewModel.swift    # Business logic and state management
└── Services/
    └── PlacesService.swift      # Data fetching layer
```

## Data Model

Each place includes:
- **Name & Category** - What it is
- **Location** - Latitude, longitude, and area/neighborhood
- **Description** - Brief overview
- **Trending Info** - Why it's popular with related notes
- **Trending Score** - Popularity rating (0-100)
- **Maps URL** - Direct link to Apple Maps

## Current Demo Data

The app currently includes 6 trending spots in Madrid:

1. **Cafe Angelica** (Malasaña) - Coffee shop famous for olive oil lattes
2. **Mercado Norte** (Centro) - Food hall with rotating chef pop-ups
3. **Rio Verde Walk** (Arganzuela) - Riverside path with street art
4. **Luna Vinyl Bar** (Chueca) - Listening bar with guest DJs
5. **Museo Patio** (Las Letras) - Gallery with courtyard cafe
6. **Azotea Aurora** (Gran Vía) - Rooftop terrace with skyline views

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open `FOMO.xcodeproj` in Xcode
3. Build and run on iOS Simulator or device

## Future Enhancements

- [ ] Connect to live API for real-time trending data
- [ ] Location-based search for any city
- [ ] User favorites and saved places
- [ ] Push notifications for trending alerts
- [ ] Photo gallery for each place
- [ ] User reviews and ratings

## License

MIT License
