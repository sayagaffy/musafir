// ignore_for_file: unnecessary_this, unnecessary_new

class Users {
  int? _page;
  int? _perPage;
  int? _total;
  int? _totalPages;
  late List<UsersModel> _data;
  Support? _support;

//public class
  List<UsersModel> get data => _data;

  Users({
    required page,
    required perPage,
    required total,
    required totalPages,
    required data,
    required support,
  }) {
    this._page = page;
    this._perPage = perPage;
    this._total = totalPages;
    this._data = data;
    this._support = support;
  }

  Users.fromJson(Map<String, dynamic> json) {
    _page = json['page'];
    _perPage = json['per_page'];
    _total = json['total'];
    _totalPages = json['total_pages'];
    if (json['data'] != null) {
      _data = <UsersModel>[];
      json['data'].forEach((v) {
        _data.add(UsersModel.fromJson(v));
      });
    }
    _support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this._page;
    data['per_page'] = this._perPage;
    data['total'] = this._total;
    data['total_pages'] = this._totalPages;
    // ignore: unnecessary_null_comparison
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    if (this._support != null) {
      data['support'] = this._support!.toJson();
    }
    return data;
  }
}

class UsersModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UsersModel({this.id, this.email, this.firstName, this.lastName, this.avatar});

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}
