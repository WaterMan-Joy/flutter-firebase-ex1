// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_firebase_ex1/models/custom_error.dart';

import '../../models/user_model.dart';

enum UsersStatus {
  initial,
  loading,
  loaded,
  error,
}

class UsersState extends Equatable {
  final UsersStatus usersStatus;
  final CustomError customError;
  final List<User> users;
  UsersState({
    required this.usersStatus,
    required this.customError,
    required this.users,
  });

  factory UsersState.initial() {
    return UsersState(
      usersStatus: UsersStatus.initial,
      customError: CustomError(),
      users: [],
    );
  }

  @override
  List<Object> get props => [usersStatus, customError, users];

  @override
  bool get stringify => true;

  UsersState copyWith({
    UsersStatus? usersStatus,
    CustomError? customError,
    List<User>? users,
  }) {
    return UsersState(
      usersStatus: usersStatus ?? this.usersStatus,
      customError: customError ?? this.customError,
      users: users ?? this.users,
    );
  }
}
