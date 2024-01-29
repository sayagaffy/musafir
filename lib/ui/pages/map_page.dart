import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:musafir/shared/theme.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // ignore: prefer_final_fields
  Location _locationController = Location();

  static const LatLng _pGooglePlex =
      LatLng(3.5277668982069166, 98.63336896363755);

  static const LatLng _pApplePark =
      LatLng(3.5185909506515554, 98.60872053826233);

  // ignore: avoid_init_to_null
  LatLng? _currentP = null;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? Center(
              child: Text(
                'Loading...',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: bold,
                ),
              ),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentP!,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                ),
                const Marker(
                  markerId: MarkerId("_sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pApplePark,
                ),
                const Marker(
                  markerId: MarkerId("_destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pGooglePlex,
                ),
              },
            ),
    );
  }

  Future<void> getLocationUpdates() async {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _servicesEnabled;
    // ignore: no_leading_underscores_for_local_identifiers
    PermissionStatus _permissionGranted;

    _servicesEnabled = await _locationController.serviceEnabled();

    if (_servicesEnabled) {
      _servicesEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();

      if (_permissionGranted != PermissionStatus.denied) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          // ignore: avoid_print
          // print(_currentP);
        });
      }
    });
  }
}
