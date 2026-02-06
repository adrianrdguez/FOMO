//
//  MapView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject private var viewModel: PlacesViewModel
    @State private var selectedPlace: Place?
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038),
            span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        )
    )

    var body: some View {
        Map(position: $position, selection: $selectedPlace) {
            ForEach(viewModel.places) { place in
                Annotation(place.name, coordinate: coordinate(for: place)) {
                    PlacePin(place: place, isSelected: selectedPlace?.id == place.id)
                }
                .tag(place)
            }
        }
        .mapStyle(
            .standard(
                elevation: .realistic,
                emphasis: .muted,
                pointsOfInterest: .excludingAll,
                showsTraffic: false
            )
        )
        .task {
            if viewModel.places.isEmpty {
                await viewModel.loadPlaces()
            }
        }
        .sheet(item: $selectedPlace) { place in
            PlaceDetailView(place: place)
        }
    }

    private func coordinate(for place: Place) -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
    }
}

private struct PlacePin: View {
    let place: Place
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 6) {
            if isSelected {
                Text(place.name)
                    .font(.system(.caption, design: .rounded))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial, in: Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                    )
            }

            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.ultraThinMaterial)
                .frame(width: isSelected ? 36 : 30, height: isSelected ? 36 : 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(place.categoryColor.opacity(0.6), lineWidth: 1)
                )
                .overlay(
                    Circle()
                        .fill(place.categoryColor)
                        .frame(width: 12, height: 12)
                )
                .shadow(color: place.categoryColor.opacity(0.4), radius: 12, y: 6)
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: isSelected)
    }
}
