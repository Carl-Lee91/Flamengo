class PlaceModel {
  final String name, address, placeId, businessStatus;
  final double lat, lng;
  final dynamic rating, priceLevel;

  PlaceModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        businessStatus = json["business_status"],
        lat = json["geometry"]["location"]["lat"],
        lng = json["geometry"]["location"]["lng"],
        address = json["vicinity"],
        placeId = json["place_id"],
        rating = json["rating"] ?? 0,
        priceLevel = json["price_level"] ?? 0;
}
