//
//  PlaceDetailView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

struct PlaceDetailView: View {
    let place: Place

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(place.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 6) {
                Text(place.category)
                    .font(.headline)
                Text(place.area)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Text(place.shortDescription)
                .font(.body)

            VStack(alignment: .leading, spacing: 8) {
                Text("Why it's trending")
                    .font(.headline)

                ForEach(place.trendingNotes, id: \.self) { note in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "sparkle")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Text(note)
                            .font(.subheadline)
                    }
                }
            }

            HStack {
                Text("Trending")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(place.trendingScore)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
    }
}
