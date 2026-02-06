//
//  PlacesService.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import Foundation

struct PlacesService {
    let endpoint: URL

    init(endpoint: URL = URL(string: "https://example.com/places.json")!) {
        self.endpoint = endpoint
    }

    func fetchPlaces() async throws -> [Place] {
        return [
            Place(
                id: "madrid-001",
                name: "Cafe Angelica",
                category: "Coffee",
                shortDescription: "Sunny corner cafe with pastelitos and cold brew.",
                latitude: 40.4269,
                longitude: -3.7036,
                area: "Malasana",
                whyTrending: "Locals are lining up for the new olive oil latte.",
                trendingNotes: [
                    "New olive oil latte just launched",
                    "Morning queue is back this week",
                    "Great sunny corner seating"
                ],
                trendingScore: 92,
                appleMapsUrl: "https://maps.apple.com/?q=Cafe%20Angelica"
            ),
            Place(
                id: "madrid-002",
                name: "Mercado Norte",
                category: "Food Hall",
                shortDescription: "Compact market with rotating chefs and wine taps.",
                latitude: 40.4158,
                longitude: -3.7074,
                area: "Centro",
                whyTrending: "A chef pop-up is drawing a dinner crowd all week.",
                trendingNotes: [
                    "Chef pop-up runs all week",
                    "Wine taps got a refresh",
                    "Live tapas station tonight"
                ],
                trendingScore: 88,
                appleMapsUrl: "https://maps.apple.com/?q=Mercado%20Norte"
            ),
            Place(
                id: "madrid-003",
                name: "Rio Verde Walk",
                category: "Outdoors",
                shortDescription: "Riverside loop with street art and sunset views.",
                latitude: 40.4059,
                longitude: -3.7210,
                area: "Arganzuela",
                whyTrending: "Evening crowds are building for the golden hour.",
                trendingNotes: [
                    "Golden hour views are popular",
                    "Fresh mural just dropped",
                    "Easy river loop for walks"
                ],
                trendingScore: 84,
                appleMapsUrl: "https://maps.apple.com/?q=Rio%20Verde%20Walk"
            ),
            Place(
                id: "madrid-004",
                name: "Luna Vinyl Bar",
                category: "Nightlife",
                shortDescription: "Listening bar with curated sets and small plates.",
                latitude: 40.4212,
                longitude: -3.6992,
                area: "Chueca",
                whyTrending: "A guest DJ series is boosting late-night traffic.",
                trendingNotes: [
                    "Guest DJ series this weekend",
                    "Limited seats at the bar",
                    "Small-plate menu is new"
                ],
                trendingScore: 90,
                appleMapsUrl: "https://maps.apple.com/?q=Luna%20Vinyl%20Bar"
            ),
            Place(
                id: "madrid-005",
                name: "Museo Patio",
                category: "Culture",
                shortDescription: "Small gallery with a quiet courtyard cafe.",
                latitude: 40.4134,
                longitude: -3.7005,
                area: "Las Letras",
                whyTrending: "A new street photography exhibit just opened.",
                trendingNotes: [
                    "New street photo exhibit",
                    "Courtyard cafe reopened",
                    "Quiet mid-day vibe"
                ],
                trendingScore: 81,
                appleMapsUrl: "https://maps.apple.com/?q=Museo%20Patio"
            ),
            Place(
                id: "madrid-006",
                name: "Azotea Aurora",
                category: "Rooftop",
                shortDescription: "Open-air terrace with skyline views and spritz.",
                latitude: 40.4183,
                longitude: -3.7079,
                area: "Gran Via",
                whyTrending: "Golden-hour tables are booking out fast.",
                trendingNotes: [
                    "Sunset tables are booking fast",
                    "New spritz menu launched",
                    "Skyline view at dusk"
                ],
                trendingScore: 95,
                appleMapsUrl: "https://maps.apple.com/?q=Azotea%20Aurora"
            )
        ]
    }
}
