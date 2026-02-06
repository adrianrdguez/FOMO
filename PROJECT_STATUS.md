# ESTADO DEL PROYECTO — FOMO

## Resumen
- App iOS en SwiftUI para descubrir restaurantes en tendencia en Madrid.
- Dos pestañas principales: **Hoy** (feed editorial) y **Mapa** (MapKit con pins personalizados).
- Datos actuales: **mock local** con 6 restaurantes españoles de Madrid en `PlacesService`.
- Estilo visual con **gradientes suaves + glassmorphism**, tipografía redondeada y animaciones sutiles.

## Estructura actual
- **Entrada**: `/Users/ucademy/Workspace/FOMO/FOMO/FOMOApp.swift` carga `ContentView`.
- **Tabs**: `/Users/ucademy/Workspace/FOMO/FOMO/ContentView.swift` define `TabView` con Hoy y Mapa.
- **MVVM**:
  - Modelo: `/Users/ucademy/Workspace/FOMO/FOMO/Place.swift`
  - ViewModel: `/Users/ucademy/Workspace/FOMO/FOMO/PlacesViewModel.swift`
  - Servicio: `/Users/ucademy/Workspace/FOMO/FOMO/PlacesService.swift`

## Hoy (Feed)
- Archivo: `/Users/ucademy/Workspace/FOMO/FOMO/TodayView.swift`
- **Hero card** para el lugar con mayor trending.
- **Bento grid** para el resto de lugares.
- Estilos de tarjeta: gradientes pastel, tintes por categoría y sombras suaves.
- **Difuminado con blur** en la parte superior para evitar corte duro.
- Tap en una tarjeta abre `PlaceDetailView`.

## Mapa
- Archivo: `/Users/ucademy/Workspace/FOMO/FOMO/MapView.swift`
- MapKit con estilo realista y muted.
- Pins personalizados con selección y animación.
- Seleccionar un pin abre `PlaceDetailView`.

## Detalle de lugar
- Archivo: `/Users/ucademy/Workspace/FOMO/FOMO/PlaceDetailView.swift`
- Header con gradiente y overlay glass.
- Panel flotante con descripción, “Por qué está en tendencia” y orb de puntuación.

## Datos y networking
- `PlacesService.fetchPlaces()` devuelve datos **mock** de restaurantes en Madrid.
- `PlacesViewModel` gestiona carga asíncrona y estado de error.
- `endpoint` existe en `PlacesService` pero aún no se usa.

## Assets
- Catálogo estándar en `/Users/ucademy/Workspace/FOMO/FOMO/Assets.xcassets`.

## Tests
- Unit tests en `FOMOTests` (scaffold vacío).
- UI tests en `FOMOUITests` con tests básicos de lanzamiento.

## Próximos pasos posibles
- Conectar a API real para datos en tiempo real.
- Añadir tests de carga, render del feed y selección en mapa.
- Refinar copy y categorías para el mercado español.
