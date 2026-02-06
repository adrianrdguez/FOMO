//
//  TodayView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var viewModel: PlacesViewModel

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Today 🔥")
        }
        .task {
            await viewModel.loadPlaces()
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading places...")
        } else if let errorMessage = viewModel.errorMessage {
            VStack(spacing: 12) {
                Text(errorMessage)
                    .multilineTextAlignment(.center)
                Button("Try Again") {
                    Task {
                        await viewModel.loadPlaces()
                    }
                }
            }
            .padding()
        } else {
            List(viewModel.places) { place in
                PlaceRow(place: place)
            }
            .listStyle(.plain)
        }
    }
}

private struct PlaceRow: View {
    let place: Place

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(place.name)
                    .font(.headline)
                Spacer()
                Text("\(place.trendingScore)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Text("\(place.category) · \(place.area)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(place.shortDescription)
                .font(.body)
                .foregroundStyle(.primary)

            Text(place.whyTrending)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}
