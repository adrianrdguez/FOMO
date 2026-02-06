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
                Marker(
                    place.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: place.latitude,
                        longitude: place.longitude
                    )
                )
                .tag(place)
            }
        }
        .task {
            if viewModel.places.isEmpty {
                await viewModel.loadPlaces()
            }
        }
        .sheet(item: $selectedPlace) { place in
            PlaceDetailView(place: place)
        }
    }
}
