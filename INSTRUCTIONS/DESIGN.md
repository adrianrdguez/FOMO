# 🍏 iOS MVP – UI/UX Refactor Brief (Liquid Glass Premium)

You are acting as a **Principal iOS Designer + Senior SwiftUI Engineer**.

Your task is to **refactor the UI/UX only** of an existing SwiftUI app to achieve an **Apple Design Award–level look & feel**.

This is **not** a feature task.  
This is a **visual, interaction, and layout refactor**.

---

## 🎯 DESIGN DIRECTION (MANDATORY)

### Style Name
**Liquid Glass Premium**

### Primary References
- **Sunlitt** (Apple Design Award Finalist 2024)
- **Arc Search** (Apple Design Award Finalist 2024)
- **Linear** (best-in-class glassmorphism on iOS)

### Core Principles
- Calm, premium, editorial
- Heavy use of translucency and iOS Materials
- Large typography, generous whitespace
- Subtle spring animations
- No visual noise

### Typography
- Use **SF Pro Rounded** throughout
- Titles dominate hierarchy
- Secondary text is soft and restrained

---

## 🗺️ MAP VIEW (MapView.swift)

### Visual Goals
- Clean, modern map with **no visual noise**
- Remove unnecessary POIs, store logos, and labels
- Subtle 3D building elevation
- Carefully curated color palette (avoid default Apple red)

### Required Changes
- Use modern MapKit APIs with:
  - Muted emphasis
  - Realistic elevation
- Custom map pins:
  - Rounded shape
  - Soft glow
  - Color adapts subtly to place category
- Smooth animated selection when tapping pins

### Bottom Navigation (CRITICAL)
Replace the default tab bar with a **floating glass dock**, inspired by Arc Search:
- Positioned slightly above bottom edge
- Rounded capsule shape
- Uses `Material.regular` or `Material.ultraThin`
- Contains two buttons only:
  - **Today 🔥**
  - **Map 🗺️**
- Buttons are large and touch-friendly
- Active tab softly glows or scales
- Transitions use fade + subtle spring

---

## 📰 TODAY FEED (TodayView.swift)

### Replace linear list with an **editorial discovery feed**

### Structure

#### 1. Hero Card (Top Trending)
- Full-width
- Taller than other cards
- Background: soft gradient or category-tinted pastel
- Very large title
- One short context line
- Trending score displayed as a **floating glass badge**

#### 2. Bento Grid Feed
- Two-column asymmetrical grid
- Primary card spans two columns
- Secondary cards below
- Soft pastel backgrounds by category
- Minimal content per card:
  - Title
  - One context line
- Small warm icon per category (coffee, nightlife, culture, etc.)

### Score Visualization
- Score is NOT plain text
- Circular **glassmorphic badge**
- Translucent background
- Color adapts to score intensity
- Light glow
- Gentle fade/scale animation on appear

---

## 📄 PLACE DETAIL (PlaceDetailView.swift)

### Layout Concept
Inspired by **Sunlitt + Crouton**

### Header
- Visual header (image or gradient)
- Subtle glass overlay
- Large title
- Category + area as secondary text

### Floating Content Panel
- Presented as a **floating sheet**
- Rounded corners (20+ radius)
- Soft shadow
- Glass or white material
- Panel visually floats over background

### “Why it’s trending”
- Displayed as a separate card
- White or glass background
- Bullet-style rows with:
  - Small icon
  - Short sentence
- Generous vertical spacing
- No paragraph blocks

Example style:
✨ New olive oil latte  
👥 Morning queues are back  
☀️ Sunny corner seating  

### Score Display (CRITICAL)
- Large circular element
- Liquid Glass / glassmorphism style
- Blur + light refraction
- Color adapts subtly to background
- Slight scale or parallax on scroll

---

## ✨ ANIMATION & INTERACTION

### Animation Style
- Use spring animations:
  - `spring(response: 0.4, dampingFraction: 0.85)`
- Everything should feel like it **floats**
- No hard edges
- No aggressive bounces

### Transitions
- Sheets fade + lift
- Cards gently scale on appear
- Active elements glow subtly

---

## 🚫 STRICT CONSTRAINTS

- ❌ Do NOT add new features
- ❌ Do NOT add new services or models
- ❌ Do NOT change business logic
- ❌ Do NOT add navigation stacks
- ❌ Keep sheet-only navigation
- ✅ Only modify:
  - Layout
  - Visual hierarchy
  - Materials
  - Animations
  - Spacing
  - Styling

---

## ✅ OUTPUT EXPECTATION

- Refactored SwiftUI views only:
  - `TodayView.swift`
  - `MapView.swift`
  - `PlaceDetailView.swift`
- Clean, readable SwiftUI code
- Strong visual hierarchy
- App should feel **modern, premium, and award-ready**

---

## 🧠 FINAL CHECK

Before finishing, ask yourself:

> “Would this feel at home on Apple’s App Store design feature page in 2025?”

If not, refine further.
