import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/ui/pages/main_page.dart';
import 'help/depedencies.dart' as dep;
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dep.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final authC = Get.put(AuthController(authRepo: Get.find()), permanent: true);
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // ignore: avoid_print
          print(snapshot.data);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: const MainPage(),
            initialRoute: snapshot.data != null && snapshot.data!.emailVerified
                ? RouteHelper.getInitial()
                : RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
