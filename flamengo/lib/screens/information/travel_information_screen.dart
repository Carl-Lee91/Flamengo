import 'dart:async';

import 'package:flamengo/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TravelInformationScreen extends StatefulWidget {
  const TravelInformationScreen({super.key});

  @override
  State<TravelInformationScreen> createState() =>
      _TravelInformationScreenState();
}

class _TravelInformationScreenState extends State<TravelInformationScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  Marker? _selectedMarker;

  final String apiKey = 'AIzaSyCawbZduh3V5Grm9jBVdM5hwUkNeTY8nys'; // 플러터 닷엔브 활용

  final ApiService _apiService =
      ApiService('AIzaSyCawbZduh3V5Grm9jBVdM5hwUkNeTY8nys');

  Future<void> _fetchNearbyPlaces(double lat, double lng) async {
    final results = await _apiService.fetchNearbyPlaces(lat, lng);

    for (var place in results) {
      final lat = place['geometry']['location']['lat'];
      final lng = place['geometry']['location']['lng'];
      final name = place['name'];

      final marker = Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: name),
      );

      _markers.add(marker);
    }
  }

  Future<void> _searchNearbyArea() async {
    final LatLngBounds visibleBounds = await _mapController!.getVisibleRegion();
    final LatLng center = visibleBounds.southwest;
    final lat = center.latitude;
    final lng = center.longitude;

    _markers.clear();
    _fetchNearbyPlaces(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              _fetchNearbyPlaces(37.551503, 126.988061);
            },
            markers: _markers,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.551503, 126.988061),
              zoom: 14,
            ),
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
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.startFloat, // 좌측에 배치
      floatingActionButton: FloatingActionButton(
        onPressed: _searchNearbyArea,
        child: const Icon(Icons.search),
      ),
    );
  }
}
