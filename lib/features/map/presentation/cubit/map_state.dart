import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flamengo/features/map/domain/entities/place.dart';

part 'map_state.freezed.dart';

@freezed
abstract class MapState with _$MapState {
  const factory MapState({
    @Default([]) List<Place> nearbyPlaces,
    @Default({}) Set<Marker> markers,
    LatLng? currentPosition,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _MapState;
}
