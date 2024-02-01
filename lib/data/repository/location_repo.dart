import 'package:musafir/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClent apiClent;
  final SharedPreferences sharedPreferences;

  LocationRepo({
    required this.apiClent,
    required this.sharedPreferences,
  });
}
