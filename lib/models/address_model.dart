// ignore_for_file: unnecessary_this

class UserMode {
  final String id;
  final DateTime createdAt;
  final String name;
  final String avatar;

  UserMode({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  factory UserMode.fromJson(Map<String, dynamic> json) {
    return UserMode(
      id: json["id"],
      createdAt: DateTime.parse(json["createdAt"]),
      name: json["name"],
      avatar: json["avatar"],
    );
  }

  static List<UserMode> fromJsonList(List list) {
    return list.map((item) => UserMode.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    return this.createdAt.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserMode model) {
    return this.id == model.id;
  }

  @override
  String toString() => name;
}

class CountryModel {
  final String id;
  final String name;
  final String iso;

  CountryModel({
    required this.id,
    required this.name,
    required this.iso,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      iso: json['iso'] ?? '',
    );
  }
}

class ProvinceModel {
  final String id;
  final String name;
  final String countryId;

  ProvinceModel({
    required this.id,
    required this.name,
    required this.countryId,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      countryId: json['country_id'] ?? '',
    );
  }

  /// Fungsi pembanding untuk DropdownSearch
  //bool isEqual(ProvinceModel other) => id == other.id;
}

class CityModel {
  final String id;
  final String name;
  final String provinceId;

  CityModel({
    required this.id,
    required this.name,
    required this.provinceId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      provinceId: json['province_id'] ?? '',
    );
  }
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
