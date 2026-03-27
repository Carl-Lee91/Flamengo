import 'package:flamengo/features/map/domain/entities/place.dart';

abstract class MapRepository {
  Future<List<Place>> getNearbyPlaces(double lat, double lng, {int radius, String type});
}
