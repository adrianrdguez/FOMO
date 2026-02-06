//
//  PlaceDetailView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

struct PlaceDetailView: View {
    let place: Place

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                DetailHeader(place: place)

                VStack(alignment: .leading, spacing: 18) {
                    Text(place.shortDescription)
                        .font(.system(.body, design: .rounded))
                        .foregroundStyle(.primary)

                    WhyTrendingCard(notes: place.trendingNotes)

                    ScoreOrb(score: place.trendingScore)
                }
                .padding(22)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                .shadow(color: Color.black.opacity(0.12), radius: 24, y: 12)
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
            .padding(.top, 24)
            .padding(.bottom, 40)
        }
        .background(detailBackground.ignoresSafeArea())
    }

    private var detailBackground: some View {
        LinearGradient(
            colors: [place.categoryColor.opacity(0.18), Color(.systemBackground)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private struct DetailHeader: View {
    let place: Place

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(headerGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 8) {
                Text(place.name)
                    .font(.system(size: 30, weight: .bold, design: .rounded))

                Text("\(place.category) · \(place.area)")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            .padding(18)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .padding(20)
        }
        .frame(height: 220)
        .padding(.horizontal, 20)
    }

    private var headerGradient: LinearGradient {
        LinearGradient(
            colors: [place.categoryColor.opacity(0.45), place.categoryColor.opacity(0.18)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

private struct WhyTrendingCard: View {
    let notes: [String]

    private let icons = ["sparkles", "person.2.fill", "sun.max.fill"]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Why it's trending")
                .font(.system(.headline, design: .rounded))

            ForEach(Array(notes.prefix(3)).indices, id: \.self) { index in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: icons[index % icons.count])
                        .foregroundStyle(.secondary)
                    Text(notes[index])
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.primary)
                }
            }
        }
        .padding(16)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

private struct ScoreOrb: View {
    let score: Int
    @State private var appear = false

    var body: some View {
        HStack {
            Text("Trending score")
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(.secondary)
            Spacer()
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .stroke(scoreColor.opacity(0.5), lineWidth: 1)
                    )
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [scoreColor.opacity(0.45), scoreColor.opacity(0.1)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .padding(6)
                Text("\(score)")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
            }
            .frame(width: 86, height: 86)
            .shadow(color: scoreColor.opacity(0.3), radius: 18, y: 10)
            .scaleEffect(appear ? 1 : 0.94)
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: appear)
        }
        .padding(16)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onAppear { appear = true }
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
