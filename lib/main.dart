import 'package:firebase_auth/firebase_auth.dart'; // di comment dulu sementara mau debuging
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
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await dep.init();
    runApp(MainApp());
  } catch (e) {
    debugPrint('terjadi kesalahan ketika initialize firebase: $e');
  }
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

//RouteHelper.getaddPlace('ChIJUdoG4cgBMTARE4jspjaeF_8', 3.1110831, 98.5024141)

// addplace?placeid=ChIJjWkS22UBMTARfGscubrO6Bg&lat=3.1126785&lng=98.5032119

//  RouteHelper.getHomeDetailPage('ChIJQYgSer8BMTARCNr6qN-yZME',
//                     'RUMAH MAKAN MUSLIM WULAN', 'homePage', 'food')

//  ? RouteHelper.getaddPlace(
//                     'ChIJjWkS22UBMTARfGscubrO6Bg', 3.1126785, 98.5032119)

// mulai kode untuk bypass login
