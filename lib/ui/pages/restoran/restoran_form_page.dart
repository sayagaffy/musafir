import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:musafir/controllers/restoran_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:musafir/ui/widgets/text_field_text.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:geolocator/geolocator.dart';

class RestoranFormPage extends StatefulWidget {
  const RestoranFormPage({super.key});

  @override
  _RestoranFormPageState createState() => _RestoranFormPageState();
}

class _RestoranFormPageState extends State<RestoranFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _restoranAddressController =
      TextEditingController();
  final TextEditingController _operationalHoursController =
      TextEditingController();
  // final RestoranController _restoranController = Get.put(RestoranController());
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _toTimeController = TextEditingController();

  LatLng? _selectedLocation;
  XFile? _selectedImage;
  String? _halalStatus;

  @override
  void dispose() {
    _nameController.dispose();
    _restoranAddressController.dispose();
    _addressController.dispose();
    _operationalHoursController.dispose();
    _fromTimeController.dispose();
    _toTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectFromTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      setState(() {
        _fromTimeController.text = formattedTime;
      });
    }
  }

  Future<void> _selectToTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      setState(() {
        _toTimeController.text = formattedTime;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      // Tangani kesalahan
      print('Error picking image: $e');
    }
  }

  Future<void> _selectLocation() async {
    // Meminta izin lokasi
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Tangani jika izin lokasi ditolak
      return;
    }

    // Mendapatkan lokasi saat ini
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
      _addressController.text =
          'Lat: ${position.latitude}, Lng: ${position.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restoran Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFieldText(
                textController: _nameController,
                hintText: 'Masukan Nama Restoran',
                label: 'Nama Restoran',
                icon: Icons.store,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _selectLocation,
                child: AbsorbPointer(
                  child: TextFieldText(
                    textController: _addressController,
                    hintText: 'Pin Lokasi Restoran',
                    label: 'Pin Lokasi',
                    icon: Icons.location_on,
                    activeBg: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFieldText(
                textController: _restoranAddressController,
                hintText: 'Masukan Alamat Restoran',
                label: 'Alamat Restoran',
                icon: Icons.restaurant_menu,
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _halalStatus,
                hint: const Text('Select Halal Status'),
                items: ['Halal', 'Non-Halal', 'Muslim-Friendly', 'Muslim-Owned']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _halalStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Jam Operasional'),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectFromTime(context),
                child: AbsorbPointer(
                  child: TextFieldText(
                    textController: _fromTimeController,
                    hintText: 'From',
                    label: 'From',
                    icon: Icons.access_time,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => _selectToTime(context),
                child: AbsorbPointer(
                  child: TextFieldText(
                    textController: _toTimeController,
                    hintText: 'To',
                    label: 'To',
                    icon: Icons.access_time,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Tambahkan Foto Restoran',
                icon: Icons.camera_alt,
                onPressed: _pickImage,
              ),
              if (_selectedImage != null)
                Image.file(
                  File(_selectedImage!.path),
                  height: 200,
                ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Simpan',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
