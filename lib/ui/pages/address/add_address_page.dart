import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/controllers/user_controller.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumer = TextEditingController();

  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(-6.233636722968254, 106.85436441421344), zoom: 14);
  late LatLng _initialPosition = LatLng(-6.233636722968254, 106.85436441421344);

  @override
  void initState() {
    _isLogged = Get.find<AuthController>().userLoggedIn();

    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["langtitude"]),
        ),
      );

      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["langtitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          children: [
            Container(
              height: 400,
              margin: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                border: Border.all(width: 1),
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 14),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    onCameraIdle: () {
                      locationController.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position) => _cameraPosition = position),
                    onMapCreated: (GoogleMapController controller) {
                      locationController.setMapController(controller);
                    },
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
