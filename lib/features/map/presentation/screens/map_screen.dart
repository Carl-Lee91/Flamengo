import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flamengo/design_system/design_system.dart';
import 'package:flamengo/features/map/presentation/cubit/map_cubit.dart';
import 'package:flamengo/features/map/presentation/cubit/map_state.dart';
import 'package:flamengo/features/map/presentation/widgets/place_info_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().initPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          if (state.currentPosition != null && _mapController != null) {
            _mapController!.animateCamera(
              CameraUpdate.newLatLng(state.currentPosition!),
            );
          }
        },
        builder: (context, state) {
          if (state.currentPosition == null) return const AppLoading();

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: state.currentPosition!,
                  zoom: 15,
                ),
                markers: _buildMarkers(context, state),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (controller) => _mapController = controller,
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: _SearchAreaButton(
                  isLoading: state.isLoading,
                  onPressed: () async {
                    final center = await _mapController?.getVisibleRegion();
                    if (center != null) {
                      final lat = (center.northeast.latitude +
                              center.southwest.latitude) /
                          2;
                      final lng = (center.northeast.longitude +
                              center.southwest.longitude) /
                          2;
                      if (context.mounted) {
                        await context.read<MapCubit>().searchNearbyPlaces(lat, lng);
                      }
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Set<Marker> _buildMarkers(BuildContext context, MapState state) {
    return state.nearbyPlaces.map((place) {
      return Marker(
        markerId: MarkerId(place.placeId),
        position: LatLng(place.lat, place.lng),
        onTap: () {
          PlaceInfoBottomSheet.show(
            context,
            place: place,
            onAddToBucketList: () {
              Navigator.of(context).pop();
              // TODO: Navigate to add bucket item with pre-filled data
            },
          );
        },
      );
    }).toSet();
  }
}

class _SearchAreaButton extends StatelessWidget {
  const _SearchAreaButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.search),
        label: const Text('Search this area'),
      ),
    );
  }
}
