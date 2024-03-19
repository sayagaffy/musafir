import 'package:flutter/material.dart';

extension BuildContextExtensionn on BuildContext {
  // metode untuk memudahkan menampilkan snackbar
  void showSnackBar(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
}
