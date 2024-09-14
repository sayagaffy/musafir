// ignore_for_file: unnecessary_string_interpolations

import 'package:get/get.dart';
import 'package:musafir/ui/pages/account/faq.dart';
import 'package:musafir/ui/pages/account/info_profile.dart';
import 'package:musafir/ui/pages/account/privasi.dart';
import 'package:musafir/ui/pages/auth/reset_password.dart';
import 'package:musafir/ui/pages/auth/sign_in_page.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import 'package:musafir/ui/pages/explore/explore_pages.dart';
import 'package:musafir/ui/pages/explore/explore_search.dart';
import 'package:musafir/ui/pages/explore/rencana_page.dart';
import 'package:musafir/ui/pages/explore/rencana_page_edit.dart';
import 'package:musafir/ui/pages/explore/search_place.dart';
import 'package:musafir/ui/pages/explore/search_place2.dart';
import 'package:musafir/ui/pages/favorite/favorite_page.dart';
import 'package:musafir/ui/pages/home/add_place.dart';
import 'package:musafir/ui/pages/home/custom.dart';
import 'package:musafir/ui/pages/home/detail_card.dart';
import 'package:musafir/ui/pages/home/home_page.dart';
import 'package:musafir/ui/pages/home/home_search.dart';
import 'package:musafir/ui/pages/home/list_kategory.dart';
import 'package:musafir/ui/pages/home/llist_card.dart';
import 'package:musafir/ui/pages/home/llist_places_card.dart';
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
  static const String homePlaceList = "/home-place-list";
  static const String addPlace = "/addplace";

  ///[EXPLORE]
  static const String explore = "/explore";
  static const String rencana = "/explore-rencana";
  static const String rencanaEdit = "/explore-rencana-edit";
  static const String exploreSearch = "/explore-search";
  static const String searchPlace = "/explore-search-place";
  static const String searchPlace2 = "/explore-search-place2";

  ///[FAVORITE]
  static const String favorite = "/favorite";

  ///[ACCOUNT]
  static const String accountInfo = "/accountinfo";
  static const String accountprivaci = "/accountprivaci";
  static const String accountFaq = "/accountfaq";

  ///[ACCOUNT]
  static const String custom = "/custom";

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
  static String getHomeSearchPage(String from) => '$homeSearch?from=$from';
  static String getHomeReview(
          String pageId, String placeName, String latlng, String from) =>
      '$homeReview?pageId=$pageId&placeName=$placeName&latlng=$latlng&from=$from';
  static String getHomeKategory(String from) => '$homekategory?from=$from';
  static String getHomeListPlacePage(String type, String search) =>
      '$homePlaceList?type=$type&search=$search';
  static String getaddPlace(String placeid, double lat, double lng) =>
      '$addPlace?placeid=$placeid&lat=$lat&lng=$lng';

  ///[EXPLORE]
  static String getExplorePage() => '$explore';
  static String getRencanaPage() => '$rencana';
  static String getRencanaPageEdit() => '$rencanaEdit';
  static String getExploreSearch() => '$exploreSearch';
  static String getSearchPlaceExplore(String type) => '$searchPlace?type=$type';
  static String getSearchPlaceExplore2(String type) =>
      '$searchPlace2?type=$type';

  ///[FAVORITE]
  static String getFavoritePage() => '$favorite';

  ///[ACCOUNT]
  static String getAccountInfo() => '$accountInfo';
  static String getAccountPrivaci() => '$accountprivaci';
  static String getAccountFaq() => '$accountFaq';

  ///[CUSTOM]
  static String getCustom() => '$custom';

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
      page: () {
        var from = Get.parameters['from'];
        return HomeSearch(from: from!);
      },
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
      page: () {
        var from = Get.parameters['from'];
        return ListKategory(from: from!);
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: homePlaceList,
      page: () {
        var type = Get.parameters['type'];
        var search = Get.parameters['search'];

        return ListPlacesCard(
          type: type!,
          search: search!,
        );
      },
      transition: Transition.fade,
    ),

    GetPage(
      name: addPlace,
      page: () {
        var placeid = Get.parameters['placeid'];
        var lat = Get.parameters['lat'];
        var lng = Get.parameters['lng'];

        return AddPlace(
          placeid: placeid!,
          lat: double.parse(lat!),
          lng: double.parse(lng!),
        );
      },
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
      name: rencanaEdit,
      page: () => const RencanaPageEdit(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: exploreSearch,
      page: () => const ExploreSearch(),
    ),

    GetPage(
      name: searchPlace,
      page: () {
        var type = Get.parameters['type'];
        return SearchPlace(type: type!);
      },
      transition: Transition.fade,
    ),

    GetPage(
      name: searchPlace2,
      page: () {
        var type = Get.parameters['type'];
        return SearchPlace2(type: type!);
      },
      transition: Transition.fade,
    ),

    ///[FAVORITE]
    GetPage(
      name: favorite,
      page: () => const FavoritePage(),
      transition: Transition.fade,
    ),

    ///[ACCOUNT]
    GetPage(
      name: accountInfo,
      page: () => const InfoProfile(),
      transition: Transition.fade,
    ),
    GetPage(
      name: accountprivaci,
      page: () => const Privasi(),
      transition: Transition.fade,
    ),
    GetPage(
      name: accountFaq,
      page: () => const Faq(),
      transition: Transition.fade,
    ),

    ///[CUSTTOM]
    GetPage(
      name: custom,
      page: () => const DropDownCust(),
      transition: Transition.fade,
    ),
  ];
}
