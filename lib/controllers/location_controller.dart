import 'dart:ffi';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musafir/controllers/geocode_controller.dart';
import 'package:musafir/data/repository/location_repo.dart';
import 'package:musafir/models/adress_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  //save location it is
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  // save location ares model
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;
  List<AddressModel> get addressList => _addressList;

  List<String> _addressTypeList = ['home', 'office', "other"];
  int _addressTypeIndex = 0;

  late Map<String, dynamic> _getAddress;

  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (_changeAddress) {
          // google manzil kritilganda bizga beradigan String holatdagi manzil
          String _address = await getAddressFromGeocode(LatLng(
            position.target.latitude,
            position.target.latitude,
          ));

          print(_address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unkow Loaction Found";
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    print('ROBERT');
    print(response.statusCode.toString());
    // print(response.body);

    // if (response.body["status"] == 'OK') {
    //   // Where raises error
    //   // _address = response.body["results"][0]['formatted_address'];
    print(response.body['results'][0]['formatted_address']);
    //   // print("printing addres" +
    //   //     response.body["results"][0]['formatted_address'].toString());
    // } else {
    //   print("Error getting the google api");
    // }
    update();
    return _address;
  }
}
