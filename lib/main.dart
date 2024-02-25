import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musafir/firebase_options.dart';
import 'package:musafir/ui/pages/get_started_page.dart';
import 'package:musafir/ui/pages/main_page.dart';
import 'package:musafir/ui/pages/sign_up_page.dart';
import 'package:musafir/ui/pages/splash_widget.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DevicePreview(
    enabled: true,
    builder: (BuildContext context) => const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/get-started': (context) => const GetStartedPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}
