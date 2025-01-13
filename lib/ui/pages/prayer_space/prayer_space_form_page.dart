import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerSpaceFormPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  PrayerSpaceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Space'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // _updateFirestore(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // void _updateFirestore(BuildContext context) async {
  //   CollectionReference masjids =
  //       FirebaseFirestore.instance.collection('masjids');
  //   await masjids.add({
  //     'name': _nameController.text,
  //     'address': _addressController.text,
  //   }).then((_) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Masjid Added')));
  //   }).catchError((error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to add masjid: $error')));
  //   });
  // }
}
