import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/routes/router_helper.dart';
import 'package:musafir/ui/pages/get_started_page.dart';
import 'package:musafir/ui/pages/main_page.dart';
import 'package:musafir/ui/pages/sign_up_page.dart';
import 'package:musafir/ui/pages/splash_widget.dart';
import 'helper/dependeccies.dart' as dep;
// import 'package:device_preview/device_preview.dart';

// void main() {
//   // runApp(DevicePreview(
//   //   enabled: true,
//   //   builder: (BuildContext context) => const MainApp(),
//   // ));

//   // runApp(const MainApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
      // routes: {
      //   '/': (context) => const SplashPage(),
      //   '/get-started': (context) => const GetStartedPage(),
      //   '/sign-up': (context) => const SignUpPage(),
      //   '/main': (context) => const MainPage(),
      // },
    );
  }
}
