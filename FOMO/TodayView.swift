//
//  TodayView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var viewModel: PlacesViewModel
    @State private var selectedPlace: Place?
    @State private var animateIn = false

    private var heroPlace: Place? {
        viewModel.places.max(by: { $0.trendingScore < $1.trendingScore })
    }

    private var gridPlaces: [Place] {
        guard let heroId = heroPlace?.id else { return viewModel.places }
        return viewModel.places.filter { $0.id != heroId }
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let errorMessage = viewModel.errorMessage {
                errorView(message: errorMessage)
            } else {
                feedView
            }
        }
        .background(screenBackground.ignoresSafeArea())
        .task {
            await viewModel.loadPlaces()
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                animateIn = true
            }
        }
        .sheet(item: $selectedPlace) { place in
            PlaceDetailView(place: place)
        }
    }

    private var feedView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                if let hero = heroPlace {
                    HeroCard(place: hero) {
                        selectedPlace = hero
                    }
                }

                LazyVGrid(columns: gridColumns, spacing: 16) {
                    if let primary = gridPlaces.first {
                        BentoCard(place: primary, isPrimary: true) {
                            selectedPlace = primary
                        }
                        .gridCellColumns(2)
                    }

                    ForEach(gridPlaces.dropFirst()) { place in
                        BentoCard(place: place, isPrimary: false) {
                            selectedPlace = place
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 120)
            .opacity(animateIn ? 1 : 0)
            .scaleEffect(animateIn ? 1 : 0.98)
        }
    }

    private var loadingView: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text("Buscando lo que está en tendencia cerca de ti")
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 14) {
            Text(message)
                .multilineTextAlignment(.center)
                .font(.system(.headline, design: .rounded))
            Button("Reintentar") {
                Task {
                    await viewModel.loadPlaces()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var gridColumns: [GridItem] {
        [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
    }

    private var screenBackground: some View {
        LinearGradient(
            colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

private struct HeroCard: View {
    let place: Place
    let onTap: () -> Void
    @State private var appear = false

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(heroGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                    )

                VStack(alignment: .leading, spacing: 10) {
                    Text("Lo más popular")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.secondary)

                    Text(place.name)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)

                    Text(place.whyTrending)
                        .font(.system(.body, design: .rounded))
                        .foregroundStyle(.secondary)
                        .lineLimit(2)

                    HStack(spacing: 8) {
                        CategoryPill(category: place.category)
                        Text(place.area)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)

                ScoreBadge(score: place.trendingScore, size: 64)
                    .padding(20)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 232)
            .shadow(color: heroShadow, radius: 24, y: 16)
        }
        .buttonStyle(.plain)
        .scaleEffect(appear ? 1 : 0.98)
        .opacity(appear ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                appear = true
            }
        }
    }

    private var heroGradient: LinearGradient {
        LinearGradient(
            colors: [place.categoryColor.opacity(0.35), place.categoryColor.opacity(0.15)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var heroShadow: Color {
        place.categoryColor.opacity(0.25)
    }
}

private struct BentoCard: View {
    let place: Place
    let isPrimary: Bool
    let onTap: () -> Void
    @State private var appear = false

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    CategoryIcon(place: place)
                    Spacer()
                }

                Text(place.name)
                    .font(.system(isPrimary ? .title3 : .headline, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Text(place.shortDescription)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .padding(18)
            .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .topLeading)
            .background(cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: place.categoryColor.opacity(0.18), radius: 16, y: 10)
        }
        .buttonStyle(.plain)
        .scaleEffect(appear ? 1 : 0.98)
        .opacity(appear ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                appear = true
            }
        }
    }

    private var cardBackground: some View {
        LinearGradient(
            colors: [place.categoryColor.opacity(0.22), place.categoryColor.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private struct CategoryPill: View {
    let category: String

    var body: some View {
        Text(category)
            .font(.system(.caption, design: .rounded))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.ultraThinMaterial, in: Capsule())
    }
}

private struct CategoryIcon: View {
    let place: Place

    var body: some View {
        Image(systemName: place.symbolName)
            .font(.system(.subheadline, design: .rounded))
            .foregroundStyle(place.categoryColor)
            .frame(width: 32, height: 32)
            .background(
                Circle()
                    .fill(place.categoryColor.opacity(0.18))
            )
    }
}

private struct ScoreBadge: View {
    let score: Int
    let size: CGFloat
    @State private var appear = false

    var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
                .overlay(
                    Circle()
                        .stroke(scoreColor.opacity(0.5), lineWidth: 1)
                )

            Text("\(score)")
                .font(.system(size: size * 0.36, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
        }
        .frame(width: size, height: size)
        .shadow(color: scoreColor.opacity(0.35), radius: 14, y: 8)
        .scaleEffect(appear ? 1 : 0.9)
        .opacity(appear ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                appear = true
            }
        }
    }

    private var scoreColor: Color {
        switch score {
        case 90...:
            return Color.orange
        case 80...:
            return Color.mint
        case 70...:
            return Color.blue
        default:
            return Color.gray
        }
    }
}

extension Place {
    var categoryColor: Color {
        switch category.lowercased() {
        case let value where value.contains("tapa"):
            return Color.orange
        case let value where value.contains("asador"):
            return Color.red
        case let value where value.contains("madril"):
            return Color.yellow
        case let value where value.contains("maris"):
            return Color.blue
        case let value where value.contains("taberna"):
            return Color.pink
        case let value where value.contains("casera"):
            return Color.green
        default:
            return Color.blue
        }
    }

    var symbolName: String {
        switch category.lowercased() {
        case let value where value.contains("tapa"):
            return "fork.knife"
        case let value where value.contains("asador"):
            return "fork.knife"
        case let value where value.contains("madril"):
            return "flame.fill"
        case let value where value.contains("maris"):
            return "fish.fill"
        case let value where value.contains("taberna"):
            return "wineglass.fill"
        case let value where value.contains("casera"):
            return "leaf.fill"
        default:
            return "mappin.circle.fill"
        }
    }
}
