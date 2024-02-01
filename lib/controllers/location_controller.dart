import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:musafir/data/repository/location_repo.dart';
import 'package:musafir/model/adress_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  // save location ares model
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;

  List<AddressModel> get addressList => _addressList;
  List<String> _addressTypeList = ['home', 'office', "other"];
  int _addressTypeIndex = 0;
}
