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
    static let initialScale: CGFloat = 0.96
    
    static let sectionSpacing: CGFloat = 24
    static let horizontalPadding: CGFloat = 20
    static let topPadding: CGFloat = 8
    
    static let heroHeight: CGFloat = 420
    static let heroCornerRadius: CGFloat = 32
    static let heroScoreSize: CGFloat = 56
    
    static let mediumCardHeight: CGFloat = 280
    static let compactCardHeight: CGFloat = 180
    static let cardCornerRadius: CGFloat = 24
    static let cardShadowRadius: CGFloat = 20
    
    static let filterBarHeight: CGFloat = 44
    static let filterPillSpacing: CGFloat = 8
    static let staggerDelay: Double = 0.05
}

// MARK: - Main View

struct TodayView: View {
    @State private var viewModel = PlacesViewModel()
    @State private var selectedPlace: Place?
    @State private var selectedCategory: String? = nil
    @State private var animateIn = false
    
    private var heroPlace: Place? {
        viewModel.places.max(by: { $0.trendingScore < $1.trendingScore })
    }
    
    private var filteredPlaces: [Place] {
        let nonHeroPlaces = viewModel.places.filter { $0.id != heroPlace?.id }
        if let category = selectedCategory {
            return nonHeroPlaces.filter { $0.category == category }
        }
        return nonHeroPlaces
    }
    
    private var availableCategories: [String] {
        Array(Set(viewModel.places.map { $0.category })).sorted()
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
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Hero Section
                if let hero = heroPlace {
                    HeroSection(place: hero) {
                        withHaptic {
                            selectedPlace = hero
                        }
                    }
                    .padding(.horizontal, LayoutConstants.horizontalPadding)
                    .padding(.top, LayoutConstants.topPadding)
                    .opacity(animateIn ? 1 : 0)
                    .offset(y: animateIn ? 0 : 20)
                    .animation(.spring(response: LayoutConstants.animationDuration, dampingFraction: LayoutConstants.animationDamping), value: animateIn)
                }
                
                // Category Filter Bar
                CategoryFilterBar(
                    categories: availableCategories,
                    selectedCategory: $selectedCategory,
                    isSticky: false
                )
                .padding(.top, 20)
                .padding(.bottom, 16)
                .opacity(animateIn ? 1 : 0)
                .animation(.spring(response: LayoutConstants.animationDuration, dampingFraction: LayoutConstants.animationDamping).delay(LayoutConstants.staggerDelay), value: animateIn)
                
                // Editorial Feed
                EditorialFeed(
                    places: filteredPlaces,
                    onSelect: { place in
                        withHaptic {
                            selectedPlace = place
                        }
                    },
                    animateIn: animateIn
                )
                .padding(.horizontal, LayoutConstants.horizontalPadding)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 100)
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            GlassShimmer()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
            Text("Descubriendo Madrid...")
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48, weight: .light))
                .foregroundStyle(.secondary)
            
            Text(message)
                .multilineTextAlignment(.center)
                .font(.system(.headline, design: .rounded))
            
            Button("Reintentar") {
                Task {
                    await viewModel.loadPlaces()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var screenBackground: some View {
        LinearGradient(
            colors: [
                Color(.systemBackground),
                Color(.secondarySystemBackground).opacity(0.5),
                Color(.systemBackground)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Hero Section

private struct HeroSection: View {
    let place: Place
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                // Photo Background
                placeholderBackground
                
                // Gradient Overlay
                LinearGradient(
                    colors: [
                        .black.opacity(0),
                        .black.opacity(0.3),
                        .black.opacity(0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Content
                VStack(alignment: .leading, spacing: 12) {
                    // Trending Badge
                    HStack(spacing: 6) {
                        Image(systemName: "flame.fill")
                            .font(.caption2)
                        Text("Tendencia")
                            .font(.system(.caption, design: .rounded).weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(.orange.opacity(0.9))
                            .overlay(
                                Capsule()
                                    .stroke(.white.opacity(0.3), lineWidth: 1)
                            )
                    )
                    .shadow(color: .orange.opacity(0.4), radius: 8, y: 4)
                    
                    // Title
                    Text(place.name)
                        .font(.system(.largeTitle, design: .rounded).weight(.bold))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    
                    // Category & Area
                    HStack(spacing: 8) {
                        Text(place.category)
                            .font(.system(.subheadline, design: .rounded).weight(.medium))
                            .foregroundStyle(.white.opacity(0.9))
                        
                        Circle()
                            .fill(.white.opacity(0.5))
                            .frame(width: 4, height: 4)
                        
                        Text(place.area)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.white.opacity(0.7))
                        
                        if let price = place.priceRange {
                            Text(price)
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                    
                    // Rating
                    if let rating = place.rating {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundStyle(.yellow)
                            Text(String(format: "%.1f", rating))
                                .font(.system(.subheadline, design: .rounded).weight(.semibold))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Score Badge
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ScoreBadge(score: place.trendingScore, size: LayoutConstants.heroScoreSize)
                            .padding(20)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: LayoutConstants.heroHeight)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.heroCornerRadius, style: .continuous))
            .shadow(
                color: place.categoryColor.opacity(0.25),
                radius: LayoutConstants.cardShadowRadius,
                y: 12
            )
            .overlay(
                RoundedRectangle(cornerRadius: LayoutConstants.heroCornerRadius, style: .continuous)
                    .stroke(.white.opacity(0.15), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(place.name), \(place.category), puntuacion \(place.trendingScore)")
        .accessibilityHint("Toca para ver detalles")
    }
    
    private var placeholderBackground: some View {
        LinearGradient(
            colors: [place.categoryColor.opacity(0.35), place.categoryColor.opacity(0.15)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Category Filter Bar

private struct CategoryFilterBar: View {
    let categories: [String]
    @Binding var selectedCategory: String?
    let isSticky: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: LayoutConstants.filterPillSpacing) {
                // All button
                FilterPill(
                    title: "Todo",
                    isSelected: selectedCategory == nil,
                    color: .primary
                ) {
                    withHaptic {
                        selectedCategory = nil
                    }
                }
                
                ForEach(categories, id: \.self) { category in
                    FilterPill(
                        title: category,
                        isSelected: selectedCategory == category,
                        color: categoryColor(for: category)
                    ) {
                        withHaptic {
                            selectedCategory = (selectedCategory == category) ? nil : category
                        }
                    }
                }
            }
            .padding(.horizontal, LayoutConstants.horizontalPadding)
        }
        .frame(height: LayoutConstants.filterBarHeight)
        .background(
            isSticky ? 
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                : nil
        )
    }
    
    private func categoryColor(for category: String) -> Color {
        switch category.lowercased() {
        case let value where value.contains("tapa"):
            return .orange
        case let value where value.contains("asador"):
            return .red
        case let value where value.contains("madril"):
            return .yellow
        case let value where value.contains("maris"):
            return .blue
        case let value where value.contains("taberna"):
            return .pink
        case let value where value.contains("casera"):
            return .green
        default:
            return .blue
        }
    }
}

private struct FilterPill: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.subheadline, design: .rounded).weight(isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? color : Color.clear)
                        .overlay(
                            Capsule()
                                .stroke(isSelected ? Color.clear : .primary.opacity(0.2), lineWidth: 1)
                        )
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Editorial Feed

private struct EditorialFeed: View {
    let places: [Place]
    let onSelect: (Place) -> Void
    let animateIn: Bool
    
    var body: some View {
        LazyVStack(spacing: 16) {
            ForEach(Array(places.enumerated()), id: \.element.id) { index, place in
                let cardType = cardType(for: index, score: place.trendingScore)
                
                EditorialCard(
                    place: place,
                    cardType: cardType,
                    onTap: { onSelect(place) }
                )
                .opacity(animateIn ? 1 : 0)
                .offset(y: animateIn ? 0 : 30)
                .animation(
                    .spring(response: LayoutConstants.animationDuration, dampingFraction: LayoutConstants.animationDamping)
                    .delay(Double(index) * LayoutConstants.staggerDelay),
                    value: animateIn
                )
            }
        }
    }
    
    private func cardType(for index: Int, score: Int) -> CardType {
        if index < 2 && score >= 85 {
            return .hero
        } else if score >= 80 {
            return .medium
        } else {
            return .compact
        }
    }
}

enum CardType {
    case hero, medium, compact
}

// MARK: - Editorial Card

private struct EditorialCard: View {
    let place: Place
    let cardType: CardType
    let onTap: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                // Photo Background
                placeholderBackground
                
                // Gradient Overlay
                LinearGradient(
                    colors: [
                        .black.opacity(0),
                        .black.opacity(0.4),
                        .black.opacity(cardType == .compact ? 0.6 : 0.8)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Top Badges
                VStack {
                    HStack {
                        // Category Badge
                        Text(place.category)
                            .font(.system(.caption, design: .rounded).weight(.medium))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .fill(place.categoryColor.opacity(0.9))
                                    .overlay(
                                        Capsule()
                                            .stroke(.white.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        
                        Spacer()
                        
                        // Score Badge
                        HStack(spacing: 2) {
                            Image(systemName: "flame.fill")
                                .font(.caption2)
                            Text("\(place.trendingScore)")
                                .font(.system(.caption, design: .rounded).weight(.bold))
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(.ultraThinMaterial)
                                .overlay(
                                    Capsule()
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                        )
                    }
                    .padding(16)
                    
                    Spacer()
                }
                
                // Content
                VStack(alignment: .leading, spacing: cardType == .compact ? 4 : 8) {
                    Text(place.name)
                        .font(cardType == .compact ? 
                            .system(.headline, design: .rounded).weight(.bold) :
                            .system(.title2, design: .rounded).weight(.bold))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    
                    HStack(spacing: 6) {
                        Text(place.area)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.white.opacity(0.8))
                        
                        if let price = place.priceRange {
                            Text("·")
                                .foregroundStyle(.white.opacity(0.6))
                            Text(price)
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        
                        if let rating = place.rating {
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                Text(String(format: "%.1f", rating))
                            }
                            .foregroundStyle(.yellow)
                        }
                    }
                    
                    if cardType != .compact {
                        Text(place.shortDescription)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.white.opacity(0.8))
                            .lineLimit(2)
                            .padding(.top, 4)
                    }
                }
                .padding(cardType == .compact ? 14 : 20)
            }
            .frame(maxWidth: .infinity)
            .frame(height: cardHeight)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cardCornerRadius, style: .continuous))
            .shadow(
                color: place.categoryColor.opacity(0.2),
                radius: isPressed ? 12 : LayoutConstants.cardShadowRadius,
                y: isPressed ? 6 : 10
            )
            .overlay(
                RoundedRectangle(cornerRadius: LayoutConstants.cardCornerRadius, style: .continuous)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(.plain)
        .pressEvents {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                isPressed = true
            }
        } onRelease: {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                isPressed = false
            }
        }
        .accessibilityLabel("\(place.name), \(place.category), puntuacion \(place.trendingScore)")
        .accessibilityHint("Toca para ver detalles")
    }
    
    private var cardHeight: CGFloat {
        switch cardType {
        case .hero:
            return LayoutConstants.heroHeight * 0.7
        case .medium:
            return LayoutConstants.mediumCardHeight
        case .compact:
            return LayoutConstants.compactCardHeight
        }
    }
    
    private var placeholderBackground: some View {
        LinearGradient(
            colors: [place.categoryColor.opacity(0.3), place.categoryColor.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Supporting Views

private struct ScoreBadge: View {
    let score: Int
    let size: CGFloat
    
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
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
                .overlay(
                    Circle()
                        .stroke(scoreColor.opacity(0.6), lineWidth: 2)
                )
            
            VStack(spacing: 0) {
                Text("\(score)")
                    .font(.system(size: size * 0.32, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text("pts")
                    .font(.system(size: size * 0.14, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: size, height: size)
        .shadow(color: scoreColor.opacity(0.4), radius: 12, y: 6)
    }
}

private struct GlassShimmer: View {
    @State private var isAnimating = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        .white.opacity(0.1),
                        .white.opacity(0.3),
                        .white.opacity(0.1)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .mask(
                GeometryReader { geometry in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.clear, .white, .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * 0.5)
                        .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
                }
            )
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}

// MARK: - Haptic Helper

private func withHaptic(action: @escaping () -> Void) {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
    action()
}

// MARK: - Button Press Modifier

private struct PressEventsModifier: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in onPress() }
                    .onEnded { _ in onRelease() }
            )
    }
}

extension View {
    func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        modifier(PressEventsModifier(onPress: onPress, onRelease: onRelease))
    }
}

// MARK: - Preview

#Preview("Today View") {
    TodayView()
}
