import 'package:flutter/material.dart';
import 'package:musafir_app/main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    MainPage mainPage = const MainPage();

    MaterialApp materialApp = MaterialApp(
      home: mainPage,
    );
    return materialApp;
  }
}
