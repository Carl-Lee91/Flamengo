import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flamengo/features/map/data/models/place_api_response.dart';

part 'places_api_client.g.dart';

@RestApi()
@injectable
abstract class PlacesApiClient {
  @factoryMethod
  factory PlacesApiClient(Dio dio) = _PlacesApiClient;

  @GET('/maps/api/place/nearbysearch/json')
  Future<NearbySearchResponse> getNearbyPlaces(
    @Query('location') String location,
    @Query('radius') int radius,
    @Query('type') String type,
    @Query('key') String apiKey,
  );
}
