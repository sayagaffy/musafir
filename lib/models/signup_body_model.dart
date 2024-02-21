class SignUpBody {
  // String name;
  // String phone;
  String email;
  String password;

  SignUpBody({
    // required this.name,
    // required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // ignore: unnecessary_this
    // data["f_name"] = this.name;
    // // ignore: unnecessary_this
    // data["phone"] = this.phone;
    // ignore: unnecessary_this
    data["email"] = this.email;
    // ignore: unnecessary_this
    data["password"] = this.password;
    return data;
  }
}
