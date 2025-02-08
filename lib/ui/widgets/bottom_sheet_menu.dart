import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/ui/pages/masjid/masjid_form_page.dart';
import 'package:musafir/ui/pages/prayer_space/prayer_space_form_page.dart';
import 'package:musafir/ui/pages/restoran/restoran_form_page.dart';

class BottomSheetMenu extends StatelessWidget {
  // final String currentPage;
  const BottomSheetMenu({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: _getMenuForPage(currentPage),
  //   );
  // }

  // Widget _getMenuForPage(String page) {
  //   switch (page) {
  //     case 'Restoran':
  //       return _getRestoranMenu();
  //     case 'Masjid':
  //       return _getMasjidMenu();
  //     case 'Prayer Space':
  //       return _getPrayerSpaceMenu();
  //     default:
  //       return _getRestoranMenu();
  //   }
  // }

  // Widget _getRestoranMenu() {
  //   return Column(
  //     children: [
  //       ListTile(
  //         leading: const Icon(Icons.restaurant),
  //         title: const Text('Add Restoran'),
  //         onTap: () {
  //           Get.to(() => const RestoranFormPage());
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _getMasjidMenu() {
  //   return Column(
  //     children: [
  //       ListTile(
  //         leading: const Icon(Icons.mosque),
  //         title: const Text('Add Masjid'),
  //         onTap: () {
  //           Get.to(() => MasjidFormPage());
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _getPrayerSpaceMenu() {
  //   return Column(
  //     children: [
  //       ListTile(
  //         leading: const Icon(Icons.back_hand),
  //         title: const Text('Add Prayer Space'),
  //         onTap: () {
  //           Get.to(() => PrayerSpaceFormPage());
  //         },
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
            // ListTile(
            //   title: const Text('Add Masjid'),
            //   onTap: () {
            //     Navigator.pop(context); // Close the bottom sheet
            //     _navigateToInfoPage(context, 'Masjid');
            //   },
            // ),
            // ListTile(
            //   title: const Text('Add Prayer Space'),
            //   onTap: () {
            //     Navigator.pop(context); // Close the bottom sheet
            //     _navigateToInfoPage(context, 'Prayer Space');
            //   },
            // ),
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
