// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';

class PostRepositroy {
  final FirebaseFirestore firebaseFirestore;
  PostRepositroy({
    required this.firebaseFirestore,
  });

  // Future<Post> upload(
  //     {required String title,
  //     required String description,
  //     required String like}) async {
  //   try {} catch (e) {}
  // }
}
