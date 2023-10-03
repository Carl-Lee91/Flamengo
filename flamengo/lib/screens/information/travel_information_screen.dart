import 'dart:async';

import 'package:flamengo/api/api_services.dart';
import 'package:flamengo/api/model/place_model.dart';
import 'package:flamengo/screens/recommend/view_models/recommend_view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TravelInformationScreen extends ConsumerStatefulWidget {
  const TravelInformationScreen({super.key});

  @override
  ConsumerState<TravelInformationScreen> createState() =>
      _TravelInformationScreenState();
}

class _TravelInformationScreenState
    extends ConsumerState<TravelInformationScreen> {
  final Set<Marker> _markers = {};
  final Geolocator geolocator = Geolocator();

  static const initialLatLng = LatLng(37.67, 126.75);
  static const initialZoom = 14.0;

  GoogleMapController? _mapController;
  Marker? _selectedMarker;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _fetchNearbyPlaces(initialLatLng.latitude, initialLatLng.longitude);
  }

  Future<void> _fetchNearbyPlaces(double lat, double lng) async {
    if (_markers.isEmpty) {
      List<PlaceModel> placeList =
          await ApiService.fetchNearbyPlacesById(lat, lng);
      setState(() {
        _markers.clear();
        for (var place in placeList) {
          final marker = _createMarker(place);
          _markers.add(marker);
        }
      });
    }

    _moveCamera(LatLng(lat, lng));
  }

  Future<void> _onLikeTap(PlaceModel place) async {
    final recommendNotifier = ref.read(recommendProvider.notifier);
    await recommendNotifier.likeStore(place);
    final isLiked = await recommendNotifier.onTapLikedStore(place);

    setState(() {
      _isLiked = isLiked;
    });
  }

  Future<void> _initIsLiked(
      PlaceModel place, ValueNotifier<bool> isLikedNotifier) async {
    _isLiked =
        await ref.read(recommendProvider.notifier).onTapLikedStore(place);
    isLikedNotifier.value = _isLiked;
  }

  void _showMarkerInfoDialog(PlaceModel place) {
    ValueNotifier<bool> isLikedNotifier = ValueNotifier<bool>(_isLiked);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  place.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await _onLikeTap(place);
                  isLikedNotifier.value = _isLiked;
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: isLikedNotifier,
                  builder: (context, isLiked, child) {
                    return isLiked
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border);
                  },
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(place.rating != 0
                  ? 'Rating: ${place.rating}'
                  : 'Rating: No Rating'),
              Text(place.priceLevel != 0
                  ? 'Price Level: About ￦${place.priceLevel}0,000'
                  : 'Price Level: No Information'),
              Text('Business Status: ${place.businessStatus}'),
              Text('Address: ${place.address}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
    _initIsLiked(place, isLikedNotifier);
  }

  Marker _createMarker(PlaceModel place) {
    return Marker(
      markerId: MarkerId(place.name),
      position: LatLng(place.lat, place.lng),
      infoWindow: place.rating == 0
          ? InfoWindow(
              onTap: () {
                _showMarkerInfoDialog(place);
              },
              title: place.name,
              snippet: 'No Rating',
            )
          : InfoWindow(
              onTap: () {
                _showMarkerInfoDialog(place);
              },
              title: place.name,
              snippet: 'Rating : ${place.rating}',
            ),
    );
  }

  void _moveCamera(LatLng target) {
    _mapController?.animateCamera(CameraUpdate.newLatLng(target));
  }

  Future<void> _searchNearbyArea() async {
    if (_mapController == null) {
      return;
    }

    final visibleBounds = await _mapController!.getVisibleRegion();
    final centerLat =
        (visibleBounds.southwest.latitude + visibleBounds.northeast.latitude) /
            2;
    final centerLng = (visibleBounds.southwest.longitude +
            visibleBounds.northeast.longitude) /
        2;

    _markers.clear();
    await _fetchNearbyPlaces(centerLat, centerLng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: _markers,
            initialCameraPosition:
                const CameraPosition(target: initialLatLng, zoom: initialZoom),
            onTap: (LatLng latLng) {
              setState(() {
                _selectedMarker = null;
              });
            },
          ),
          if (_selectedMarker != null) ...[
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  _selectedMarker!.infoWindow.title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _searchNearbyArea,
        child: const Icon(Icons.search),
      ),
    );
  }
}
