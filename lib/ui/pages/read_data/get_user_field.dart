/// Widget GetUserField adalah widget stateless yang digunakan untuk mengambil
/// dan menampilkan data dari dokumen pengguna di koleksi 'users' pada Firestore.
///
/// Parameter:
/// - `documenId`: ID dokumen pengguna yang ingin diambil datanya.
/// - `queryField`: Nama field yang ingin diambil dari dokumen pengguna.
///
/// Widget ini menggunakan FutureBuilder untuk mengambil data dari Firestore.
/// Jika data berhasil diambil, widget akan menampilkan nilai dari field yang
/// ditentukan. Jika data masih dalam proses pengambilan, widget akan menampilkan
/// teks 'loading..'.
library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserField extends StatelessWidget {
  final String documenId;
  final String queryField;

  const GetUserField({
    super.key,
    required this.documenId,
    required this.queryField,
  });

  @override
  Widget build(BuildContext context) {
    //get collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder(
      future: users.doc(documenId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Text('${data[queryField]}');
        }
        return const Text('loading..');
      }),
    );
  }
}
