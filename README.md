# Flamengo

A personal travel companion app for managing your bucket list destinations and tracking your travel footprint.

## Features

- **Bucket List** - Save places you want to visit, organized by category (Food, Culture, Nature, Nightlife, Shopping)
- **Map Explore** - Discover nearby places using Google Maps and Places API, then add them to your bucket list
- **Travel Footprint** - Visualize your visited places grouped by country and city
- **Stats Dashboard** - Track your travel statistics with category breakdowns and progress
- **Profile** - Manage your traveler profile with initials avatar

## Architecture

Clean Architecture with feature-based module structure:

```
lib/
├── core/           # DI, Router, Network, Firebase config, Constants
├── design_system/  # Theme, Colors, Typography, Shared widgets
├── features/
│   ├── auth/           # Google + Apple Sign-In
│   ├── bucket_list/    # CRUD for bucket list places
│   ├── map/            # Google Maps + Places API search
│   ├── footprint/      # Travel footprint visualization
│   ├── stats/          # Statistics dashboard
│   ├── profile/        # User profile management
│   └── settings/       # App settings & logout
└── shell/          # Bottom navigation shell
```

Each feature follows the **data / domain / presentation** layer pattern:
- **domain** - Entities (freezed) + Repository interfaces
- **data** - Data sources (Firebase RTDB, Retrofit) + Repository implementations
- **presentation** - Cubit (flutter_bloc) + Screens + Widgets

## Tech Stack

| Category | Technology |
|----------|-----------|
| Framework | Flutter 3.41+ / Dart 3.11+ |
| State Management | flutter_bloc (Cubit) |
| DI | get_it + injectable |
| Navigation | GoRouter (StatefulShellRoute) |
| Database | Firebase Realtime Database |
| Auth | Firebase Auth (Google + Apple) |
| Network | Dio + Retrofit |
| Maps | Google Maps Flutter + Places API |
| Code Gen | freezed + json_serializable + build_runner |
| Design | Material 3, Inter font, ScreenUtil (375x812) |
| Analytics | Firebase Analytics + Crashlytics |
| Testing | bloc_test + mocktail |

## Getting Started

### Prerequisites

- Flutter SDK (via [fvm](https://fvm.app/))
- Firebase project configured
- Google Maps API key
- Google Sign-In configured (OAuth 2.0)

### Setup

1. Clone the repository
```bash
git clone https://github.com/your-username/flamengo.git
cd flamengo
```

2. Create `.env` file in the project root
```env
FIREBASE_API_KEY=your_firebase_api_key
MAP_API_KEY=your_google_maps_api_key
```

3. Add Google Maps API key to `android/local.properties`
```properties
google.map.key=your_google_maps_api_key
```

4. Install dependencies and generate code
```bash
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
```

5. Run the app
```bash
fvm flutter run
```

### Running Tests

```bash
fvm flutter test
```

## Firebase Realtime DB Structure

```
users/{uid}/
├── profile/
│   ├── displayName
│   ├── email
│   ├── createdAt
│   └── updatedAt
├── bucketList/{placeId}/
│   ├── name, address, lat, lng
│   ├── country, city, category
│   ├── memo, rating, visited, visitedAt
│   ├── createdAt, googlePlaceId
│   └── ...
└── stats/
    ├── totalPlaces, visitedPlaces
    ├── countries, cities
    └── categoryStats/{category}/
        ├── total
        └── visited
```

## Android Build Config

| Property | Value |
|----------|-------|
| compileSdk | 36 |
| minSdk | 23 (Android 6.0+) |
| targetSdk | 35 |
| AGP | 8.9.1 |
| Kotlin | 2.3.10 |
| Gradle | 8.11.1 |
| Java | 17 |

## Design System

- **Primary Color**: Coral Orange (`#FF6B35`)
- **Secondary Color**: Navy (`#004E89`)
- **Font**: Inter (via google_fonts)
- **Spacing**: gap package
- **Design Size**: 375 x 812 (ScreenUtil)
