//
//  ContentView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PlacesViewModel()
    @State private var selectedTab: Tab = .today

    var body: some View {
        TabView(selection: $selectedTab) {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "flame.fill")
                }
                .tag(Tab.today)

            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                .tag(Tab.map)
        }
        .safeAreaInset(edge: .top) {
            GlassNavBar(title: selectedTab == .today ? "Today" : "Map")
        }
        .environmentObject(viewModel)
        .fontDesign(.rounded)
        .background(Color(.systemBackground))
    }
}

private enum Tab {
    case today
    case map
}

private struct GlassNavBar: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .shadow(color: Color.black.opacity(0.08), radius: 8, y: 4)
    }
}
