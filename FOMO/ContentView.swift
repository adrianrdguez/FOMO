//
//  ContentView.swift
//  FOMO
//
//  Created by Ucademy on 6/2/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Hoy", systemImage: "flame.fill")
                }

            MapView()
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }
        }
    }
}
