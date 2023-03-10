import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static DatabaseHelper instance = DatabaseHelper();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('user');

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
        .add({'name': 'Dhruvin', 'age': 20})
        .then((value) => print("User Add Successfully"))
        .catchError(
          (error) => print("Error : $error"),
        );
  }
}
