class PlaceModel {
  final String name, businessStatus, address, placeId;
  final double lat, lng;
  final dynamic rating, priceLevel;

  PlaceModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        businessStatus = json["business_status"],
        lat = json["geometry"]["location"]["lat"],
        lng = json["geometry"]["location"]["lng"],
        address = json["vicinity"],
        placeId = json["place_id"],
        rating = json["rating"] ?? "No Rating",
        priceLevel = json["price_level"] ?? "No Information";
}
