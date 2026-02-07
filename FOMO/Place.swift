//
//  Place.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import Foundation
import SwiftUI

struct Place: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let category: String
    let shortDescription: String
    let latitude: Double
    let longitude: Double
    let area: String
    let whyTrending: String
    let trendingNotes: [String]
    let trendingScore: Int
    let appleMapsUrl: String
    let imageURL: String?
    let priceRange: String?
    let rating: Double?
    let openNow: Bool?
}

// MARK: - Category Color Extension

extension Place {
    var categoryColor: Color {
        switch category.lowercased() {
        case let value where value.contains("tapa"):
            return .orange
        case let value where value.contains("asador"):
            return .red
        case let value where value.contains("madril"):
            return .yellow
        case let value where value.contains("maris"):
            return .blue
        case let value where value.contains("taberna"):
            return .pink
        case let value where value.contains("casera"):
            return .green
        default:
            return .blue
        }
    }
}
