import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserField extends StatelessWidget {
  final String documenId;
  final String queryField;
  final TextStyle textStyle;

  const GetUserField(
      {super.key,
      required this.documenId,
      required this.queryField,
      required this.textStyle});

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

          return Text('${data[queryField]}', style: textStyle);
        }
        return const Text('loading..');
      }),
    );
  }
}
