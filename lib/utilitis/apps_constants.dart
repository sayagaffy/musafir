// ignore_for_file: constant_identifier_names

class AppConstans {
  static const String APP_NAME = "Musafir app";
  static const int APP_VERSION = 1;
  // static const String BASE_URL = "https://mvs.bslmeiyu.com";
  static const String BASE_URL = "https://reqres.in";
  static const String USERS_LIST = "/api/users";

  ///[AUTH]
  static const String LOGIN_URI = "/api/login";
  // static const String LOGIN_URI = "/api/v1/auth/login";
  // static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String REGISTRATION_URI = "/api/register";

  ///[Google API]
  static const String BASE_URL_GOOGLE = "https://maps.googleapis.com/maps/api";
  static const String API_GKEY = "AIzaSyBe_89LiN8WdHYk5mPcmAey5ZyheaskwE0";
  static const String GEOCODE = "/geocode/json";
  static const String SEARCH = "/place/autocomplete/json";
  static const String NEARBYSEARCH = "/place/nearbysearch/json";
  static const String PLACE_DETAIL = "/place/details/json";
  static const String PLACE_PHOTO =
      '$BASE_URL_GOOGLE/place/photo?maxwidth=400&key=$API_GKEY&photo_reference=';
  static const String PLACE_TEXTSEARCH = "/place/textsearch/json";

  ///[AUTH]
  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
}
