//
//  TodayView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

// MARK: - Layout Constants

private enum LayoutConstants {
    static let animationDuration: Double = 0.4
    static let animationDamping: Double = 0.85
    static let initialScale: CGFloat = 0.98
    
    static let sectionSpacing: CGFloat = 24
    static let gridSpacing: CGFloat = 16
    static let gridItemSpacing: CGFloat = 16
    static let horizontalPadding: CGFloat = 20
    static let topPadding: CGFloat = 16
    static let bottomPadding: CGFloat = 120
    
    static let heroCardHeight: CGFloat = 232
    static let heroCardCornerRadius: CGFloat = 28
    static let heroCardShadowRadius: CGFloat = 24
    static let heroCardShadowY: CGFloat = 16
    static let heroCardPadding: CGFloat = 24
    static let heroCardScorePadding: CGFloat = 20
    static let heroCardScoreSize: CGFloat = 64
    
    static let bentoCardCornerRadius: CGFloat = 22
    static let bentoCardMinHeight: CGFloat = 150
    static let bentoCardPadding: CGFloat = 18
    static let bentoCardShadowRadius: CGFloat = 16
    static let bentoCardShadowY: CGFloat = 10
    static let bentoCardStrokeOpacity: CGFloat = 0.2
    
    static let scoreBadgeShadowRadius: CGFloat = 14
    static let scoreBadgeShadowY: CGFloat = 8
    static let scoreBadgeInitialScale: CGFloat = 0.9
}

// MARK: - Main View

struct TodayView: View {
    @State private var viewModel = PlacesViewModel()
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
            withAnimation(.spring(response: LayoutConstants.animationDuration, dampingFraction: LayoutConstants.animationDamping)) {
                animateIn = true
            }
        }
        .sheet(item: $selectedPlace) { place in
            PlaceDetailView(place: place)
        }
    }

    private var feedView: some View {
        ScrollView {
            VStack(spacing: LayoutConstants.sectionSpacing) {
                if let hero = heroPlace {
                    HeroCard(place: hero) {
                        selectedPlace = hero
                    }
                }

                LazyVGrid(columns: gridColumns, spacing: LayoutConstants.gridSpacing) {
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
            .padding(.horizontal, LayoutConstants.horizontalPadding)
            .padding(.top, LayoutConstants.topPadding)
            .padding(.bottom, LayoutConstants.bottomPadding)
            .opacity(animateIn ? 1 : 0)
            .scaleEffect(animateIn ? 1 : LayoutConstants.initialScale)
        }
        .scrollIndicators(.hidden)
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
            GridItem(.flexible(), spacing: LayoutConstants.gridItemSpacing),
            GridItem(.flexible(), spacing: LayoutConstants.gridItemSpacing)
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

// MARK: - Hero Card

private struct HeroCard: View {
    let place: Place
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: LayoutConstants.heroCardCornerRadius, style: .continuous)
                    .fill(heroGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: LayoutConstants.heroCardCornerRadius, style: .continuous)
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
                .padding(LayoutConstants.heroCardPadding)
                .frame(maxWidth: .infinity, alignment: .leading)

                ScoreBadge(score: place.trendingScore, size: LayoutConstants.heroCardScoreSize)
                    .padding(LayoutConstants.heroCardScorePadding)
            }
            .frame(maxWidth: .infinity)
            .frame(height: LayoutConstants.heroCardHeight)
            .shadow(color: heroShadow, radius: LayoutConstants.heroCardShadowRadius, y: LayoutConstants.heroCardShadowY)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(place.name), \(place.category), puntuación de tendencia \(place.trendingScore)")
        .accessibilityHint("Toca para ver detalles")
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

// MARK: - Bento Card

private struct BentoCard: View {
    let place: Place
    let isPrimary: Bool
    let onTap: () -> Void

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
            .padding(LayoutConstants.bentoCardPadding)
            .frame(maxWidth: .infinity, minHeight: LayoutConstants.bentoCardMinHeight, maxHeight: LayoutConstants.bentoCardMinHeight, alignment: .topLeading)
            .background(cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: LayoutConstants.bentoCardCornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(LayoutConstants.bentoCardStrokeOpacity), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.bentoCardCornerRadius, style: .continuous))
            .shadow(color: place.categoryColor.opacity(0.18), radius: LayoutConstants.bentoCardShadowRadius, y: LayoutConstants.bentoCardShadowY)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(place.name), \(place.category)")
        .accessibilityHint("Toca para ver detalles")
    }

    private var cardBackground: some View {
        LinearGradient(
            colors: [place.categoryColor.opacity(0.22), place.categoryColor.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Supporting Views

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
        .shadow(color: scoreColor.opacity(0.35), radius: LayoutConstants.scoreBadgeShadowRadius, y: LayoutConstants.scoreBadgeShadowY)
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

// MARK: - Place Extensions

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
