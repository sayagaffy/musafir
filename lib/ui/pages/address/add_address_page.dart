import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  final CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(-6.233636722968254, 106.85436441421344), zoom: 16);
  late LatLng _initialPosition;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
