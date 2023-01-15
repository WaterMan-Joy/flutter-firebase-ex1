// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:flutter_firebase_ex1/models/custom_error.dart';

import '../../models/user_model.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final User user;
  final CustomError customError;
  ProfileState({
    required this.profileStatus,
    required this.user,
    required this.customError,
  });

  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initialUser(),
      customError: CustomError(),
    );
  }

  @override
  List<Object> get props => [profileStatus, user, customError];

  @override
  bool get stringify => true;

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? customError,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      customError: customError ?? this.customError,
    );
  }
}
