//
//  PlaceDetailView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

struct PlaceDetailView: View {
    let place: Place
    @Environment(\.dismiss) private var dismiss
    @State private var appear = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Photo Header
                PhotoHeader(place: place)
                
                // Content Panel
                VStack(alignment: .leading, spacing: 24) {
                    // Title Section
                    TitleSection(place: place)
                    
                    // Quick Info Row
                    QuickInfoRow(place: place)
                    
                    Divider()
                        .background(.primary.opacity(0.1))
                    
                    // Why Trending Section
                    WhyTrendingSection(notes: place.trendingNotes)
                    
                    // Score Section
                    ScoreSection(score: place.trendingScore)
                    
                    // Action Button
                    ActionButton(appleMapsUrl: place.appleMapsUrl)
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .shadow(color: .black.opacity(0.1), radius: 30, y: -10)
                )
                .offset(y: -40)
            }
        }
        .background(detailBackground.ignoresSafeArea())
        .overlay(alignment: .topLeading) {
            CloseButton { dismiss() }
                .padding(.top, 16)
                .padding(.leading, 16)
        }
        .onAppear { 
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                appear = true
            }
        }
    }
    
    private var detailBackground: some View {
        LinearGradient(
            colors: [
                place.categoryColor.opacity(0.2),
                Color(.systemBackground),
                Color(.systemBackground)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Photo Header

private struct PhotoHeader: View {
    let place: Place
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Photo
            if let imageURL = place.imageURL {
                CachedAsyncImage(url: imageURL)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 320)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } else {
                gradientPlaceholder
            }
            
            // Gradient overlay
            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.3),
                    .black.opacity(0.6)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 160)
        }
        .frame(height: 320)
    }
    
    private var gradientPlaceholder: some View {
        LinearGradient(
            colors: [
                place.categoryColor.opacity(0.4),
                place.categoryColor.opacity(0.2)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Title Section

private struct TitleSection: View {
    let place: Place
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(place.name)
                    .font(.system(.title, design: .rounded).weight(.bold))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                // Open Status Badge
                if let openNow = place.openNow {
                    StatusBadge(isOpen: openNow)
                }
            }
            
            HStack(spacing: 6) {
                Text(place.category)
                    .font(.system(.subheadline, design: .rounded).weight(.medium))
                    .foregroundStyle(place.categoryColor)
                
                Circle()
                    .fill(.primary.opacity(0.3))
                    .frame(width: 4, height: 4)
                
                Text(place.area)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Status Badge

private struct StatusBadge: View {
    let isOpen: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(isOpen ? Color.green : Color.red)
                .frame(width: 6, height: 6)
            
            Text(isOpen ? "Abierto" : "Cerrado")
                .font(.system(.caption, design: .rounded).weight(.medium))
        }
        .foregroundStyle(isOpen ? .green : .red)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill((isOpen ? Color.green : Color.red).opacity(0.1))
        )
    }
}

// MARK: - Quick Info Row

private struct QuickInfoRow: View {
    let place: Place
    
    var body: some View {
        HStack(spacing: 20) {
            if let rating = place.rating {
                InfoItem(
                    icon: "star.fill",
                    value: String(format: "%.1f", rating),
                    label: "Valoracion",
                    color: .yellow
                )
            }
            
            if let price = place.priceRange {
                InfoItem(
                    icon: "eurosign.circle.fill",
                    value: price,
                    label: "Precio",
                    color: .green
                )
            }
            
            InfoItem(
                icon: "flame.fill",
                value: "\(place.trendingScore)",
                label: "Tendencia",
                color: .orange
            )
        }
    }
}

// MARK: - Info Item

private struct InfoItem: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(color)
                Text(value)
                    .font(.system(.body, design: .rounded).weight(.semibold))
            }
            
            Text(label)
                .font(.system(.caption, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.thinMaterial)
        )
    }
}

// MARK: - Why Trending Section

private struct WhyTrendingSection: View {
    let notes: [String]
    private let icons = ["sparkles", "person.2.fill", "heart.fill"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Por que esta en tendencia")
                .font(.system(.headline, design: .rounded))
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(notes.prefix(3).enumerated()), id: \.offset) { index, note in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: icons[index % icons.count])
                            .font(.system(.callout, design: .rounded))
                            .foregroundStyle(.orange)
                            .frame(width: 24)
                        
                        Text(note)
                            .font(.system(.body, design: .rounded))
                            .foregroundStyle(.primary)
                            .lineLimit(2)
                    }
                }
            }
        }
    }
}

// MARK: - Score Section

private struct ScoreSection: View {
    let score: Int
    @State private var animatedScore = 0
    
    private var scoreColor: Color {
        switch score {
        case 90...:
            return .orange
        case 80...:
            return .mint
        case 70...:
            return .blue
        default:
            return .gray
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Puntuacion de tendencia")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
                
                Text(scoreDescription)
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(scoreColor)
            }
            
            Spacer()
            
            ZStack {
                // Background circle
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .stroke(scoreColor.opacity(0.4), lineWidth: 2)
                    )
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: CGFloat(animatedScore) / 100)
                    .stroke(
                        scoreColor.gradient,
                        style: StrokeStyle(lineWidth: 4, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .padding(6)
                
                // Score text
                VStack(spacing: 0) {
                    Text("\(animatedScore)")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                    
                    Text("/100")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 90, height: 90)
            .shadow(color: scoreColor.opacity(0.3), radius: 12, y: 6)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.thinMaterial)
        )
        .onAppear {
            withAnimation(.spring(response: 1.2, dampingFraction: 0.8)) {
                animatedScore = score
            }
        }
    }
    
    private var scoreDescription: String {
        switch score {
        case 90...:
            return "Tendencia maxima"
        case 80...:
            return "Muy popular"
        case 70...:
            return "Popular"
        default:
            return "En alza"
        }
    }
}

// MARK: - Action Button

private struct ActionButton: View {
    let appleMapsUrl: String
    
    var body: some View {
        Button(action: openMaps) {
            HStack(spacing: 8) {
                Image(systemName: "map.fill")
                Text("Ver en Mapas")
            }
            .font(.system(.headline, design: .rounded))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                Capsule()
                    .fill(.orange.gradient)
            )
            .shadow(color: .orange.opacity(0.4), radius: 12, y: 6)
        }
        .padding(.top, 8)
    }
    
    private func openMaps() {
        if let url = URL(string: appleMapsUrl) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Close Button

private struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 32))
                .foregroundStyle(.white.opacity(0.9))
                .background(Circle().fill(.black.opacity(0.3)))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Cached Async Image

private struct CachedAsyncImage: View {
    let url: String
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
                    .task {
                        await loadImage()
                    }
            }
        }
    }
    
    private var placeholder: some View {
        ZStack {
            Color.gray.opacity(0.2)
            ProgressView()
        }
    }
    
    private func loadImage() async {
        guard let url = URL(string: url) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.image = uiImage
                }
            }
        } catch {
            print("Failed to load image: \(error)")
        }
    }
}

// MARK: - Preview

#Preview("Place Detail") {
    PlaceDetailView(
        place: Place(
            id: "preview-001",
            name: "Taberna Malasana",
            category: "Tapas",
            shortDescription: "Tapas de autor, vermut y cocina de barra con ambiente vibrante.",
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
        )
    )
}
