import 'package:get/get.dart';
import 'package:musafir/ui/pages/auth/sign_in_page.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import 'package:musafir/ui/pages/explore/explore_pages.dart';
import 'package:musafir/ui/pages/explore/rencana_page.dart';
import 'package:musafir/ui/pages/main_page.dart';
import 'package:musafir/ui/pages/splash_widget.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String sigIn = "/sign-in";
  static const String sigUp = "/sign-up";
  static const String initial = "/main";
  static const String explore = "/explore";
  static const String rencana = "/explore-rencana";

  // ignore: unnecessary_string_interpolations
  static String getSplashPage() => '$splashPage';
  // ignore: unnecessary_string_interpolations
  static String getInitial() => '$initial';
  // ignore: unnecessary_string_interpolations
  static String getsigInPage() => '$sigIn';
  // ignore: unnecessary_string_interpolations
  static String getsignUpPage() => '$sigUp';
  // ignore: unnecessary_string_interpolations
  static String getExplorePage() => '$explore';
  // ignore: unnecessary_string_interpolations
  static String getRencanaPage() => '$rencana';

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: initial,
      page: () => const MainPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: sigIn,
      page: () => const SignInPage1(),
      transition: Transition.fade,
    ),
    GetPage(
      name: sigUp,
      page: () => const SignUpPage1(),
      transition: Transition.fade,
    ),
    GetPage(
      name: explore,
      page: () => const ExplorePage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: rencana,
      page: () => const RencanaPage(),
      transition: Transition.rightToLeft,
    ),
  ];
}
