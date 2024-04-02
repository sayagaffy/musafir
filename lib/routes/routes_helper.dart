// ignore_for_file: unnecessary_string_interpolations

import 'package:get/get.dart';
import 'package:musafir/ui/pages/auth/reset_password.dart';
import 'package:musafir/ui/pages/auth/sign_in_page.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import 'package:musafir/ui/pages/explore/explore_pages.dart';
import 'package:musafir/ui/pages/explore/explore_search.dart';
import 'package:musafir/ui/pages/explore/rencana_page.dart';
import 'package:musafir/ui/pages/favorite/favorite_page.dart';
import 'package:musafir/ui/pages/home/detail_card.dart';
import 'package:musafir/ui/pages/home/home_page.dart';
import 'package:musafir/ui/pages/home/home_search.dart';
import 'package:musafir/ui/pages/home/list_kategory.dart';
import 'package:musafir/ui/pages/home/llist_card.dart';
import 'package:musafir/ui/pages/home/review_place.dart';
import 'package:musafir/ui/pages/home/set_location.dart';
import 'package:musafir/ui/pages/main_page.dart';
import 'package:musafir/ui/pages/search/textfield_search_google.dart';
import 'package:musafir/ui/pages/splash_widget.dart';

class RouteHelper {
  ///INITIAL

  ///[MAIN]
  static const String initial = "/main";

  ///[SPLASH SCREEN]
  static const String splashPage = "/splash-page";

  ///[AUTH]
  static const String sigIn = "/sign-in";
  static const String sigUp = "/sign-up";
  static const String resetPassword = "/resetpassword";

  ///[SEARCH]
  static const String search = "/search";

  ///[HOME]
  static const String home = "/home";
  static const String homedetail = "/home-detail";
  static const String homelist = "/home-list";
  static const String setlocation = "/setlocation";
  static const String homeSearch = "/home-search";
  static const String homeReview = "/home-review";
  static const String homekategory = "/home-kategory";

  ///[EXPLORE]
  static const String explore = "/explore";
  static const String rencana = "/explore-rencana";
  static const String exploreSearch = "/explore-search";

  ///[FAVORITE]
  static const String favorite = "/favorite";

  ///INITIAL PARAM

  ///[MAIN]
  static String getInitial() => '$initial';

  ///[SPLASH SCREEN]
  static String getSplashPage() => '$splashPage';

  ///[AUTH]
  static String getsigInPage() => '$sigIn';
  static String getsignUpPage() => '$sigUp';
  static String getResetPasswordPage() => '$resetPassword';

  ///[SEARCH]
  static String getSearchPage() => '$search';

  ///[HOME]
  static String getHomePage() => '$home';
  static String getHomeDetailPage(
          String pageId, String page, String from, String type) =>
      '$homedetail?pageId=$pageId&page=$page&from=$from&type=$type';
  static String getHomeListPage(String type, String search) =>
      '$homelist?type=$type&search=$search';
  static String getLocationPage() => '$setlocation';
  static String getHomeSearchPage() => '$homeSearch';
  static String getHomeReview(
          String pageId, String placeName, String latlng, String from) =>
      '$homeReview?pageId=$pageId&placeName=$placeName&latlng=$latlng&from=$from';
  static String getHomeKategory() => '$homekategory';

  ///[EXPLORE]
  static String getExplorePage() => '$explore';
  static String getRencanaPage() => '$rencana';
  static String getExploreSearch() => '$exploreSearch';

  ///[FAVORITE]
  static String getFavoritePage() => '$favorite';

  ///[SET SCREEN AND SET PARAM]

  static List<GetPage> routes = [
    ///[MAIN]
    GetPage(
      name: initial,
      page: () => const MainPage(),
      transition: Transition.fade,
    ),

    ///[SPLASH SCREEN]
    GetPage(
      name: splashPage,
      page: () => const SplashPage(),
    ),

    ///[AUTH]
    GetPage(
      name: sigIn,
      page: () => const SignInPage1(),
      transition: Transition.fade,
    ),
    GetPage(
      name: resetPassword,
      page: () => const ResetPassword(),
      transition: Transition.fade,
    ),
    GetPage(
      name: sigUp,
      page: () => const SignUpPage1(),
      transition: Transition.fade,
    ),

    ///[SEARCH]
    GetPage(
      name: search,
      page: () => const TextfieldSearchGoogle(),
      transition: Transition.leftToRight,
    ),

    ///[HOME]
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
        var type = Get.parameters['type'];
        return DetailCard(
            pageId: pageId!, page: page!, from: from!, type: type!);
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: homelist,
      page: () {
        var type = Get.parameters['type'];
        var search = Get.parameters['search'];
        return ListCard(type: type!, search: search!);
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
    GetPage(
      name: homeReview,
      page: () {
        var pageId = Get.parameters['pageId'];
        var placeName = Get.parameters['placeName'];
        var latlng = Get.parameters['latlng'];
        var from = Get.parameters['from'];
        return ReviewPlace(
          pageId: pageId!,
          placeName: placeName!,
          latlng: latlng!,
          from: from!,
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: homekategory,
      page: () => const ListKategory(),
      transition: Transition.fade,
    ),

    ///[EXPLORE]
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
      name: exploreSearch,
      page: () => const ExploreSearch(),
    ),

    ///[FAVORITE]
    GetPage(
      name: favorite,
      page: () => const FavoritePage(),
      transition: Transition.fade,
    ),
  ];
}
