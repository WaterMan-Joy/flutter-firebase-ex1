// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter_firebase_ex1/constants/db_constants.dart';
import 'package:flutter_firebase_ex1/models/custom_error.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  // 유저상태가 변경되면 알려주는 것 같음
  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  Future<void> signup(
      {required String name,
      required String email,
      required String password}) async {
    try {
      // 이 함수는 계정을 만들고 동시에 로그인 까지 가능하다
      final fbAuth.UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final signedInUser = userCredential.user!;
      await userRef.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        'profileImage':
            'https://blog.kakaocdn.net/dn/XsNHt/btrb3m0cuQb/62QmvGg1bUVrI5uZfcWEi1/img.png',
        'point': 0,
        'lank': 'bronze',
      });
    }
    // 파이어 베이스 오류와 일반 오류를 일부로 분리를 해놨다
    on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, errorMsg: e.message!, plugin: e.plugin);
    } catch (e) {
      CustomError(
          code: 'Exception Error',
          errorMsg: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }

  Future<void> signin({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    }

    // 파이어베이스 에러와 일반 에러와 분리
    on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, errorMsg: e.message!, plugin: e.plugin);
    } catch (e) {
      CustomError(
          code: 'Exception Error',
          errorMsg: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }

  Future<void> singout() async {
    await firebaseAuth.signOut();
  }
}
