//
//  PlacesViewModel.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import Foundation

@MainActor
@Observable
final class PlacesViewModel {
    private(set) var places: [Place] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    private let service: PlacesService

    init(service: PlacesService = PlacesService()) {
        self.service = service
    }

    func loadPlaces() async {
        isLoading = true
        errorMessage = nil
        do {
            places = try await service.fetchPlaces()
        } catch {
            errorMessage = "No se pudieron cargar los lugares."
        }
        isLoading = false
    }
}
