import 'package:get/get.dart';
import 'package:musafir/ui/pages/auth/sign_in_page.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import 'package:musafir/ui/pages/explore/explore_pages.dart';
import 'package:musafir/ui/pages/explore/rencana_page.dart';
import 'package:musafir/ui/pages/home/detail_card.dart';
import 'package:musafir/ui/pages/home/home_page.dart';
import 'package:musafir/ui/pages/home/llist_card.dart';
import 'package:musafir/ui/pages/home/set_location.dart';
import 'package:musafir/ui/pages/main_page.dart';
import 'package:musafir/ui/pages/search/textfield_search_google.dart';
import 'package:musafir/ui/pages/splash_widget.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String sigIn = "/sign-in";
  static const String sigUp = "/sign-up";
  static const String initial = "/main";
  static const String search = "/search";
  static const String explore = "/explore";
  static const String rencana = "/explore-rencana";
  static const String home = "/home";
  static const String homedetail = "/home-detail";
  static const String homelist = "/home-list";
  static const String setlocation = "/setlocation";

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
  // ignore: unnecessary_string_interpolations
  static String getSearchPage() => '$search';
  // ignore: unnecessary_string_interpolations
  static String getHomePage() => '$home';
  // ignore: unnecessary_string_interpolations
  static String getHomeDetailPage(int pageId, String page, String from) =>
      '$homedetail?pageId=$pageId&page=$page&from=$from';
  // ignore: unnecessary_string_interpolations
  static String getHomeListPage(String type) => '$homelist?type=$type';
  // ignore: unnecessary_string_interpolations
  static String getLocationPage() => '$setlocation';

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
    GetPage(
      name: search,
      page: () => const TextfieldSearchGoogle(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: homedetail,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        var from = Get.parameters['from'];
        return DetailCard(pageId: int.parse(pageId!), page: page!, from: from!);
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: homelist,
      page: () {
        var type = Get.parameters['type'];
        return ListCard(type: type!);
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: setlocation,
      page: () => const SetLoaction(),
      transition: Transition.fade,
    ),
  ];
}
