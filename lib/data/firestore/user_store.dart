import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musafir/base/show_custom_snackbar.dart';

class UserStore {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // collection reference
  final CollectionReference dbUsers =
      FirebaseFirestore.instance.collection('users');

  Future createUser({
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
    return await dbUsers.doc(auth.currentUser!.email).set({
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

  Future getUserDetail() async {
    return await dbUsers
        .doc(auth.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        return ('Document does not exist on the database');
      }
    });
  }

  Future updateUserData(dynamic data) async {
    try {
      final querySnapshot =
          await dbUsers.doc(auth.currentUser!.email).update(data);
      return querySnapshot;
    } catch (error) {
      showCustomSnackBar(error.toString());
      throw 'failed';
    }
  }

  ///[Expample void]
  // void getDataUser() async {
  //   var locationController = Get.find<LocationController>();

  //   var authC = Get.find<AuthController>();
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(authC.auth.currentUser!.email)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       Map<String, dynamic> data =
  //           documentSnapshot.data() as Map<String, dynamic>;

  //       setState(() {
  //         name = data['firstName'];
  //         address = data['address'];
  //         latlang = data['lat'] != null
  //             ? '${data['lat']},${data['long']}'
  //             : locationController.latlng.toString();
  //       });
  //     } else {
  //       return ('Document does not exist on the database');
  //     }
  //   });
  // }
}
