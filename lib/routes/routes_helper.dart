// ignore_for_file: unnecessary_string_interpolations

import 'package:get/get.dart';
import 'package:musafir/ui/pages/auth/sign_in_page.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import 'package:musafir/ui/pages/explore/explore_pages.dart';
import 'package:musafir/ui/pages/explore/rencana_page.dart';
import 'package:musafir/ui/pages/home/detail_card.dart';
import 'package:musafir/ui/pages/home/home_page.dart';
import 'package:musafir/ui/pages/home/home_search.dart';
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
  static const String homeSearch = "/home-search";

  static String getSplashPage() => '$splashPage';

  static String getInitial() => '$initial';

  static String getsigInPage() => '$sigIn';

  static String getsignUpPage() => '$sigUp';

  static String getExplorePage() => '$explore';

  static String getRencanaPage() => '$rencana';

  static String getSearchPage() => '$search';

  static String getHomePage() => '$home';

  static String getHomeDetailPage(String pageId, String page, String from) =>
      '$homedetail?pageId=$pageId&page=$page&from=$from';

  static String getHomeListPage(String type) => '$homelist?type=$type';

  static String getLocationPage() => '$setlocation';

  static String getHomeSearchPage() => '$homeSearch';

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
        return DetailCard(pageId: pageId!, page: page!, from: from!);
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
    GetPage(
      name: homeSearch,
      page: () => const HomeSearch(),
      transition: Transition.fade,
    ),
  ];
}
