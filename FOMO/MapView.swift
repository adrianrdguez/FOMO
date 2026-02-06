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
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038),
            span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        )
    )

    var body: some View {
        NavigationStack {
            Map(position: $position) {
                ForEach(viewModel.places) { place in
                    Marker(
                        place.name,
                        coordinate: CLLocationCoordinate2D(
                            latitude: place.latitude,
                            longitude: place.longitude
                        )
                    )
                }
            }
            .navigationTitle("Map")
        }
        .task {
            if viewModel.places.isEmpty {
                await viewModel.loadPlaces()
            }
        }
    }
}
