//
//  Place.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import Foundation

struct Place: Identifiable, Codable {
    let id: String
    let name: String
    let category: String
    let shortDescription: String
    let latitude: Double
    let longitude: Double
    let area: String
    let whyTrending: String
    let trendingScore: Int
    let appleMapsUrl: String
}
