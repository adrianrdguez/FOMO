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
                name: "Taberna Malasana",
                category: "Tapas",
                shortDescription: "Tapas de autor, vermut y cocina de barra.",
                latitude: 40.4274,
                longitude: -3.7036,
                area: "Malasana",
                whyTrending: "Nueva carta de pinchos y barra llena desde las 20:00.",
                trendingNotes: [
                    "Pinchos nuevos cada semana",
                    "Vermut de grifo muy pedido",
                    "Reserva rapida para mesas altas"
                ],
                trendingScore: 92,
                appleMapsUrl: "https://maps.apple.com/?q=Taberna%20Malasana%20Madrid"
            ),
            Place(
                id: "madrid-002",
                name: "Asador Gran Via",
                category: "Asador",
                shortDescription: "Carnes a la brasa y cocina castellana clasica.",
                latitude: 40.4194,
                longitude: -3.7059,
                area: "Gran Via",
                whyTrending: "Menu de chuleton con reservas agotadas.",
                trendingNotes: [
                    "Chuleton de vaca vieja",
                    "Menu degustacion de brasas",
                    "Cocina a la vista"
                ],
                trendingScore: 90,
                appleMapsUrl: "https://maps.apple.com/?q=Asador%20Gran%20Via%20Madrid"
            ),
            Place(
                id: "madrid-003",
                name: "Casa Chamberi",
                category: "Cocina madrilena",
                shortDescription: "Cocido, callos y guisos de temporada.",
                latitude: 40.4340,
                longitude: -3.7038,
                area: "Chamberi",
                whyTrending: "El cocido de los miercoles esta a tope.",
                trendingNotes: [
                    "Cocido en dos vuelcos",
                    "Callos con un toque picante",
                    "Raciones generosas"
                ],
                trendingScore: 88,
                appleMapsUrl: "https://maps.apple.com/?q=Casa%20Chamberi%20Madrid"
            ),
            Place(
                id: "madrid-004",
                name: "Marisqueria La Latina",
                category: "Marisqueria",
                shortDescription: "Marisco fresco y arroces para compartir.",
                latitude: 40.4110,
                longitude: -3.7085,
                area: "La Latina",
                whyTrending: "Jornadas de arroz caldoso y marisco del dia.",
                trendingNotes: [
                    "Arroz caldoso muy solicitado",
                    "Marisco traido cada manana",
                    "Barra con ostras"
                ],
                trendingScore: 85,
                appleMapsUrl: "https://maps.apple.com/?q=Marisqueria%20La%20Latina%20Madrid"
            ),
            Place(
                id: "madrid-005",
                name: "Bodega Salamanca",
                category: "Taberna",
                shortDescription: "Vinos por copas, conservas premium y raciones.",
                latitude: 40.4260,
                longitude: -3.6830,
                area: "Salamanca",
                whyTrending: "Cata de vinos y nuevas raciones cada semana.",
                trendingNotes: [
                    "Carta de vinos por copas amplia",
                    "Anchoas y conservas top",
                    "Mesas de barra con mucho ambiente"
                ],
                trendingScore: 83,
                appleMapsUrl: "https://maps.apple.com/?q=Bodega%20Salamanca%20Madrid"
            ),
            Place(
                id: "madrid-006",
                name: "Meson Lavapies",
                category: "Cocina casera",
                shortDescription: "Platos de cuchara y menu del dia.",
                latitude: 40.4098,
                longitude: -3.7045,
                area: "Lavapies",
                whyTrending: "Menu del dia con cola a mediodia.",
                trendingNotes: [
                    "Platos de cuchara caseros",
                    "Postres tradicionales",
                    "Precio redondo"
                ],
                trendingScore: 80,
                appleMapsUrl: "https://maps.apple.com/?q=Meson%20Lavapies%20Madrid"
            )
        ]
    }
}
