import 'dart:async';

import 'package:flamengo/api/api_services.dart';
import 'package:flamengo/api/model/place_model.dart';
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
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  final Geolocator geolocator = Geolocator();
  Marker? _selectedMarker;
  bool isLiked = false;

  static const initialLatLng = LatLng(37.67, 126.75);
  static const initialZoom = 14.0;

  @override
  void initState() {
    super.initState();
    _fetchNearbyPlaces(initialLatLng.latitude, initialLatLng.longitude);
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _fetchNearbyPlaces(double lat, double lng) async {
    if (_markers.isEmpty) {
      List<PlaceModel> placeList =
          await ApiService.fetchNearbyPlacesById(lat, lng);
      setState(() {
        for (var place in placeList) {
          final marker = _createMarker(place);
          _markers.add(marker);
        }
      });
    }

    _moveCamera(LatLng(lat, lng));
  }

  Future<void> _setLiked() async {}

  void _showMarkerInfoDialog(PlaceModel place) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(place.name),
              GestureDetector(
                onTap: () {},
                child: isLiked
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              place.rating != 0
                  ? Text('Rating: ${place.rating}')
                  : const Text('Rating: No Rating'),
              place.priceLevel != 0
                  ? Text('Price Level: About ￦${place.priceLevel}0,000')
                  : const Text('Price Level: No Information'),
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
  }

  Marker _createMarker(PlaceModel place) {
    return Marker(
      markerId: MarkerId(place.name),
      position: LatLng(place.lat, place.lng),
      infoWindow: place.rating != 0
          ? InfoWindow(
              onTap: () {
                _showMarkerInfoDialog(place);
              },
              title: place.name,
              snippet: 'Rating: ${place.rating},',
            )
          : InfoWindow(
              onTap: () {
                _showMarkerInfoDialog(place);
              },
              title: place.name,
              snippet: 'Rating: No Rating,',
            ),
    );
  }

  void _moveCamera(LatLng target) {
    _mapController?.animateCamera(CameraUpdate.newLatLng(target));
  }

  void _searchNearbyArea() async {
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
