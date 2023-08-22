import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiKey;

  ApiService(this.apiKey);

  Future<List<Map<String, dynamic>>> fetchNearbyPlaces(
      double lat, double lng) async {
    final response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=1000&type=restaurant|cafe&key=$apiKey', // 예외처리
    ));

    if (response.statusCode == 200) {
      // 예외처리
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final results = data['results'];
        return List<Map<String, dynamic>>.from(results);
      }
    }
    return [];
  }
}
