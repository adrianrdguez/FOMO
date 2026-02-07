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
                shortDescription: "Tapas de autor, vermut y cocina de barra con ambiente vibrante en el corazon de Malasana.",
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
                appleMapsUrl: "https://maps.apple.com/?q=Taberna%20Malasana%20Madrid",
                imageURL: "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=800&q=80",
                priceRange: "€€",
                rating: 4.7,
                openNow: true
            ),
            Place(
                id: "madrid-002",
                name: "Asador Gran Via",
                category: "Asador",
                shortDescription: "Carnes a la brasa y cocina castellana clasica en un ambiente elegante y tradicional.",
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
                appleMapsUrl: "https://maps.apple.com/?q=Asador%20Gran%20Via%20Madrid",
                imageURL: "https://images.unsplash.com/photo-1544025162-d76694265947?w=800&q=80",
                priceRange: "€€€",
                rating: 4.8,
                openNow: true
            ),
            Place(
                id: "madrid-003",
                name: "Casa Chamberi",
                category: "Cocina madrilena",
                shortDescription: "Cocido, callos y guisos de temporada en un ambiente familiar y acogedor.",
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
                appleMapsUrl: "https://maps.apple.com/?q=Casa%20Chamberi%20Madrid",
                imageURL: "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&q=80",
                priceRange: "€€",
                rating: 4.6,
                openNow: false
            ),
            Place(
                id: "madrid-004",
                name: "Marisqueria La Latina",
                category: "Marisqueria",
                shortDescription: "Marisco fresco y arroces para compartir en pleno barrio de La Latina.",
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
                appleMapsUrl: "https://maps.apple.com/?q=Marisqueria%20La%20Latina%20Madrid",
                imageURL: "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800&q=80",
                priceRange: "€€€",
                rating: 4.5,
                openNow: true
            ),
            Place(
                id: "madrid-005",
                name: "Bodega Salamanca",
                category: "Taberna",
                shortDescription: "Vinos por copas, conservas premium y raciones en el exclusivo barrio de Salamanca.",
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
                appleMapsUrl: "https://maps.apple.com/?q=Bodega%20Salamanca%20Madrid",
                imageURL: "https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800&q=80",
                priceRange: "€€",
                rating: 4.4,
                openNow: true
            ),
            Place(
                id: "madrid-006",
                name: "Meson Lavapies",
                category: "Cocina casera",
                shortDescription: "Platos de cuchara y menu del dia con sabor casero en el multicultural Lavapies.",
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
                appleMapsUrl: "https://maps.apple.com/?q=Meson%20Lavapies%20Madrid",
                imageURL: "https://images.unsplash.com/photo-1547592180-85f173990554?w=800&q=80",
                priceRange: "€",
                rating: 4.3,
                openNow: false
            ),
            Place(
                id: "madrid-007",
                name: "El Paraguas",
                category: "Tapas",
                shortDescription: "Gastronomia de mercado con toque moderno y producto de temporada.",
                latitude: 40.4200,
                longitude: -3.6880,
                area: "Recoletos",
                whyTrending: "Nueva temporada de setas y jamon iberico.",
                trendingNotes: [
                    "Producto de temporada",
                    "Cocina de mercado",
                    "Carta que cambia mensual"
                ],
                trendingScore: 87,
                appleMapsUrl: "https://maps.apple.com/?q=El%20Paraguas%20Madrid",
                imageURL: "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&q=80",
                priceRange: "€€€",
                rating: 4.6,
                openNow: true
            ),
            Place(
                id: "madrid-008",
                name: "Casa Mono",
                category: "Taberna",
                shortDescription: "Cocina de autor en formato tapa con una carta creativa y sorprendente.",
                latitude: 40.4095,
                longitude: -3.7020,
                area: "La Latina",
                whyTrending: "Nueva carta de invierno con platos de cuchara.",
                trendingNotes: [
                    "Cocina creativa",
                    "Tapas de autor",
                    "Ambiente joven"
                ],
                trendingScore: 86,
                appleMapsUrl: "https://maps.apple.com/?q=Casa%20Mono%20Madrid",
                imageURL: "https://images.unsplash.com/photo-1550966871-3ed3c47e2ce2?w=800&q=80",
                priceRange: "€€",
                rating: 4.5,
                openNow: true
            )
        ]
    }
}
