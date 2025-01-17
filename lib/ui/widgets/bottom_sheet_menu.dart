import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/ui/pages/masjid/masjid_form_page.dart';
import 'package:musafir/ui/pages/prayer_space/prayer_space_form_page.dart';
import 'package:musafir/ui/pages/restoran/restoran_form_page.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: const Text('Add Restoran'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _navigateToInfoPage(context, 'Restoran');
              },
            ),
            ListTile(
              title: const Text('Add Masjid'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _navigateToInfoPage(context, 'Masjid');
              },
            ),
            ListTile(
              title: const Text('Add Prayer Space'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _navigateToInfoPage(context, 'Prayer Space');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToInfoPage(BuildContext context, String selectedValue) {
    if (selectedValue == 'Restoran') {
      Get.to(() => const RestoranFormPage());
    } else if (selectedValue == 'Masjid') {
      Get.to(() => MasjidFormPage());
    } else if (selectedValue == 'Prayer Space') {
      Get.to(() => PrayerSpaceFormPage());
    }
  }
}
