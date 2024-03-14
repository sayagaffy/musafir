import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musafir/data/entities/user.dart';
import 'package:musafir/firebase_options.dart';
import 'package:musafir/presentation/pages/get_started_page.dart';
import 'package:musafir/presentation/pages/main_page.dart';
import 'package:musafir/presentation/pages/sign_up_page.dart';
import 'package:musafir/presentation/pages/splash_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MainApp()),
  );
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
        '/main': (context) => const MainPage(
              user: User(uid: "", email: "", firstName: "", lastName: ""),
            ),
      },
    );
  }
}
