// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flamengo/screens/recommend/models/place_list_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PlacelistModel Test", () {
    test("Constructor", () {
      final place = PlaceListModel(
        name: "name",
        businessStatus: "businessStatus",
        address: "address",
        placeId: "placeId",
        rating: 1,
        priceLevel: 1,
      );
      expect(place.placeId, "placeId");
    });
    test(".fromJson Constructor", () {
      final place = PlaceListModel.fromJson(json: {
        "name": "name",
        "businessStatus": "businessStatus",
        "address": "address",
        "placeId": "placeId",
        "rating": 1,
        "priceLevel": 1,
      });
      expect(place.name, "name");
      expect(place.rating, isInstanceOf<dynamic>());
    });
    test("toJson Method", () {
      final place = PlaceListModel(
        name: "name",
        businessStatus: "businessStatus",
        address: "address",
        placeId: "placeId",
        rating: 1,
        priceLevel: 1,
      );
      final json = place.toJson();
      expect(json["placeId"], "placeId");
      expect(json["likes"], isInstanceOf<dynamic>());
    });
  });
}
