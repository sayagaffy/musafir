import 'package:flutter/material.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
    );
  }
}
