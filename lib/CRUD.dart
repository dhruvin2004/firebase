import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseHelper {
  static DatabaseHelper instance = DatabaseHelper();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  updateData({int? index}) async {
    var docSnap = await user.get();
    var docId = docSnap.docs;

    return user
        .doc(docId[index!].id)
        .update({'name': 'Dhruvin'})
        .then((value) => print("Update Successfully"))
        .catchError(
          (error) => print('Error : $error'),
        );
  }

  deleteData({int? index}) async {
    var docSnap = await user.get();
    var docId = docSnap.docs;

    return user
        .doc(docId[index!].id)
        .delete()
        .then((value) => print("Update Successfully"))
        .catchError(
          (error) => print('Error : $error'),
        );
  }

  insertData() {
    return user
        .add({'name': name.text, 'age': age.text})
        .then((value) => print("User Add Successfully"))
        .catchError(
          (error) => print("Error : $error"),
        );
  }
}
