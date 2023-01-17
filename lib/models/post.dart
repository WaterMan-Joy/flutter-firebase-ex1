// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String title;
  final String description;
  final int like;
  Post({
    required this.title,
    required this.description,
    required this.like,
  });

  factory Post.formDoc(DocumentSnapshot postDoc) {
    final postData = postDoc.data() as Map<String, dynamic>;

    return Post(
        title: postData['title'],
        description: postData['description'],
        like: postData['like']);
  }

  factory Post.initial() {
    return Post(
      title: '',
      description: '',
      like: 0,
    );
  }

  @override
  List<Object> get props => [title, description, like];

  @override
  bool get stringify => true;

  Post copyWith({
    String? title,
    String? description,
    int? like,
  }) {
    return Post(
      title: title ?? this.title,
      description: description ?? this.description,
      like: like ?? this.like,
    );
  }
}
