import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import 'package:flamengo/core/utils/logger.dart';
import 'package:flamengo/features/map/domain/entities/place.dart';
import 'package:flamengo/features/map/domain/repositories/map_repository.dart';
import 'package:flamengo/features/map/presentation/cubit/map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  MapCubit(this._mapRepository) : super(const MapState());

  final MapRepository _mapRepository;

  Future<void> initPosition() async {
    emit(state.copyWith(isLoading: true));
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }

      final position = await Geolocator.getCurrentPosition();
      log.i('[Map] position: ${position.latitude}, ${position.longitude}');
      emit(state.copyWith(
        currentPosition: LatLng(position.latitude, position.longitude),
        isLoading: false,
      ));
    } catch (e, st) {
      log.e('[Map] initPosition failed, fallback to Seoul', error: e, stackTrace: st);
      emit(state.copyWith(
        currentPosition: const LatLng(37.5665, 126.9780),
        isLoading: false,
      ));
    }
  }

  Future<void> searchNearbyPlaces(double lat, double lng) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final places = await _mapRepository.getNearbyPlaces(lat, lng);
      final markers = places.map((place) {
        return Marker(
          markerId: MarkerId(place.placeId),
          position: LatLng(place.lat, place.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address,
          ),
        );
      }).toSet();

      log.i('[Map] searchNearby: ${places.length} places found');
      emit(state.copyWith(
        nearbyPlaces: places,
        markers: markers,
        isLoading: false,
      ));
    } catch (e, st) {
      log.e('[Map] searchNearbyPlaces failed', error: e, stackTrace: st);
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Place? getPlaceById(String placeId) {
    return state.nearbyPlaces.where((p) => p.placeId == placeId).firstOrNull;
  }
}
