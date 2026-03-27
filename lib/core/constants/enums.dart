enum PlaceCategory {
  food,
  culture,
  nature,
  nightlife,
  shopping,
  other;

  String get label {
    switch (this) {
      case PlaceCategory.food:
        return 'Food';
      case PlaceCategory.culture:
        return 'Culture';
      case PlaceCategory.nature:
        return 'Nature';
      case PlaceCategory.nightlife:
        return 'Nightlife';
      case PlaceCategory.shopping:
        return 'Shopping';
      case PlaceCategory.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case PlaceCategory.food:
        return '🍽️';
      case PlaceCategory.culture:
        return '🏛️';
      case PlaceCategory.nature:
        return '🌿';
      case PlaceCategory.nightlife:
        return '🌙';
      case PlaceCategory.shopping:
        return '🛍️';
      case PlaceCategory.other:
        return '📌';
    }
  }
}
