// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_ex1/models/custom_error.dart';

import '../models/user_model.dart';

class UsersRepositroy {
  final FirebaseFirestore firebaseFirestore;
  UsersRepositroy({
    required this.firebaseFirestore,
  });

  Future<List<User>?> getUserList() async {
    try {
      CollectionReference<Map<String, dynamic>> collectionReference =
          FirebaseFirestore.instance.collection('users');
      print('collectionReference : $collectionReference');
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collectionReference.get();
      print('querySnapshot : $querySnapshot');

      List<User> userList = [];
      for (var doc in querySnapshot.docs) {
        User user = User.fromDoc(doc);
        userList.add(user);
      }
      // final finalUser = userList.map(
      //   (e) {
      //     return e.name;
      //   },
      // );
      print(userList);
      // print(finalUser);
      return userList;
      // return finalUser;

    }

    //
    on FirebaseException catch (e) {
      CustomError(code: e.code, errorMsg: e.message!, plugin: e.plugin);
    } catch (e) {
      CustomError(
          code: e.toString(), errorMsg: e.toString(), plugin: e.toString());
    }
    return null;
  }
}
