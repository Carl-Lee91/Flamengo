class PlaceListModel {
  final String name, address, placeId, businessStatus;
  final dynamic rating, priceLevel;

  PlaceListModel({
    required this.name,
    required this.businessStatus,
    required this.address,
    required this.placeId,
    required this.rating,
    required this.priceLevel,
  });

  PlaceListModel.fromJson({
    required Map<String, dynamic> json,
  })  : name = json["name"],
        businessStatus = json["businessStatus"],
        address = json["address"],
        placeId = json["placeId"],
        rating = json["rating"] ?? 0,
        priceLevel = json["priceLevel"] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "businessStatus": businessStatus,
      "address": address,
      "placeId": placeId,
      "rating": rating,
      "priceLevel": priceLevel,
    };
  }
}
