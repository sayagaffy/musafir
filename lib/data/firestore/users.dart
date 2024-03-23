import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musafir/base/show_custom_snackbar.dart';

class DbUsers {
  // collection reference
  final CollectionReference dbUsers =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(
    String docId, {
    String? username,
    String? bio,
    String? photoURL,
    String? firstName,
    String? lastName,
    String? phone,
    String? provider,
    String? address,
    String? latlang,
  }) async {
    return await dbUsers.doc(docId).set({
      'username': username,
      'bio': bio,
      'profilePhoto': photoURL,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'provider': provider,
      'address': address,
      'lat': latlang,
      'long': latlang,
      'creatAt': DateTime.now(),
    });
  }

  Future getUserDetail(String docId) async {
    return await dbUsers.doc(docId).get();
  }

  Future<void> updateUserData(String docId, dynamic data) async {
    try {
      final querySnapshot = await dbUsers.doc(docId).update(data);
      return querySnapshot;
    } catch (error) {
      showCustomSnackBar(error.toString());

      throw 'failed';
    }
  }
}
