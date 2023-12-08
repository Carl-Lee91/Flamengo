class PlaceListModel {
  final String name, address, placeId, businessStatus;
  final num? rating, priceLevel;

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
}
  // TODO:썸네일 가져올것