// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_ex1/constants/db_constants.dart';
import 'package:flutter_firebase_ex1/models/custom_error.dart';

import '../models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<void> getUsers() async {
    try {} catch (e) {}
  }

  // User 모델 타입으로 리턴하는 함수를 만든다
  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await userRef.doc(uid).get();
      print('***** userDoc : $userDoc *****');
      print('***** userDoc.date : ${userDoc.data()}');

      final user = FirebaseFirestore.instance.collection('users').doc(uid).id;
      print('user : ${user}');

      if (userDoc.exists) {
        final currerntUser = User.fromDoc(userDoc);
        print('***** currerntUser $currerntUser *****');
        return currerntUser;
      }
      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, errorMsg: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(code: '', errorMsg: e.toString(), plugin: 'e');
    }
  }
}
