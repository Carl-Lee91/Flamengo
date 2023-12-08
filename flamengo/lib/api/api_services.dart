import 'package:flamengo/api/model/place_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<PlaceModel>> fetchNearbyPlacesById(
      double lat, double lng) async {
    List<PlaceModel> placeModelInstances = [];
    final apiKey = dotenv.get("MAP_API_KEY");
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=1000&type=food&key=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> placeDBs = jsonDecode(response.body);
      for (var placeDB in placeDBs["results"]) {
        final instance = PlaceModel.fromJson(placeDB);
        placeModelInstances.add(instance);
      }
      return placeModelInstances;
    }
    throw Error();
  }
}
