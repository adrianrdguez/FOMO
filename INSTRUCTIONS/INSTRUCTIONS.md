# PROJECT: iOS MVP – Trending Places Near You

You are an expert iOS engineer building a **lean MVP** in **SwiftUI**.
The goal is to ship a **usable TestFlight build in days**, not weeks.
Prioritize **speed, clarity, and real-world usage** over scalability or polish.

---

## 🎯 PRODUCT GOAL

Build an iOS app that answers ONE question extremely well:

> “Where should I go today that’s trending right now near me?”

This is **NOT** Google Maps.
This is a **trend radar**, based on manually curated data for now.

---

## 🧠 CORE PRINCIPLES (VERY IMPORTANT)

- Fake the algorithm: data is manually curated
- No user accounts, no login
- No likes, comments, or reviews
- No scraping or automation
- Minimal backend (JSON-based)
- Feed-first UX, map is secondary
- The app must feel usable even with only 15–20 places

---

## 🛠 TECHNOLOGY STACK (STRICT)

- Swift 5.9+
- SwiftUI
- MapKit (Apple Maps only)
- CoreLocation (user location)
- Async/Await
- No UIKit
- No third-party UI frameworks
- Data loaded from a **public JSON endpoint**
- iOS 17+ target

---

## 📱 APP STRUCTURE

Use **TabView** with 2 tabs:

### Tab 1 — “Today 🔥” (HOME – MOST IMPORTANT)
Feed-style vertical scroll.

### Tab 2 — “Map”
Simple map with colored pins.

---

## 🗂 DATA MODEL (KEEP IT SIMPLE)

Define a single model:

```swift
struct Place: Identifiable, Codable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let area: String           // e.g. "Malasaña"
    let whyTrending: String    // 1 short honest sentence
    let trendingScore: Int     // 0–100
    let appleMapsUrl: String
}
