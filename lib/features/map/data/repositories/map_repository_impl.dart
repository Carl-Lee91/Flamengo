import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/features/map/domain/entities/place.dart';
import 'package:flamengo/features/map/domain/repositories/map_repository.dart';
import 'package:flamengo/features/map/data/datasources/places_api_client.dart';

@Injectable(as: MapRepository)
class MapRepositoryImpl implements MapRepository {
  MapRepositoryImpl(this._apiClient);

  final PlacesApiClient _apiClient;

  @override
  Future<List<Place>> getNearbyPlaces(
    double lat,
    double lng, {
    int radius = 1000,
    String type = 'restaurant',
  }) async {
    final apiKey = dotenv.get('MAP_API_KEY');
    final response = await _apiClient.getNearbyPlaces(
      '$lat,$lng',
      radius,
      type,
      apiKey,
    );

    return response.results
        .where((r) => r.placeId != null && r.name != null)
        .map((r) => Place(
              name: r.name!,
              address: r.vicinity ?? '',
              placeId: r.placeId!,
              lat: r.geometry?.location?.lat ?? lat,
              lng: r.geometry?.location?.lng ?? lng,
              businessStatus: r.businessStatus,
              rating: (r.rating ?? 0).toDouble(),
              priceLevel: (r.priceLevel ?? 0).toInt(),
            ))
        .toList();
  }
}
