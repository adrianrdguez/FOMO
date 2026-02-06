//
//  ContentView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PlacesViewModel()

    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today 🔥", systemImage: "flame.fill")
                }

            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
