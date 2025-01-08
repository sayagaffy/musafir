// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/main_page_controller.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/tab_config.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mainPageC = Get.find<MainPageController>();

    PersistentTabController _controller = PersistentTabController(
        initialIndex: mainPageC.menuTabController.value);

    Future _diplayBottomSheet(BuildContext context) {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Container(
                height: 200,
                color: Colors.white,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // list 3 menu button disini
                      ListTile(
                        title: Text('Add Restoran'),
                        onTap: (null),
                      ),
                      ListTile(
                        title: Text('Add Masjid'),
                        onTap: (null),
                      ),
                      ListTile(
                        title: Text('Add Prayer Space'),
                        onTap: (null),
                      ),
                    ],
                  ),
                ),
              ));
    }

    return Scaffold(
      body: Stack(
        children: [
          PersistentTabView(
            controller: _controller,
            navBarBuilder: (navBarConfig) => Style4BottomNavBar(
              navBarConfig: navBarConfig,
              navBarDecoration:
                  const NavBarDecoration(padding: EdgeInsets.only(bottom: 5)),
            ),
            onTabChanged: (index) {
              mainPageC.menuTabController.value = index;
            },
            tabs: buildTabConfigs(),
          ),
          Positioned(
            bottom: 100, // Jarak tombol dari bawah tab navigasi.
            right: 24, // Jarak tombol dari kanan.
            child: FloatingActionButton(
              onPressed: () {
                _diplayBottomSheet(context);
              },
              backgroundColor: kBlueColor,
              foregroundColor: kWhiteColor,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
