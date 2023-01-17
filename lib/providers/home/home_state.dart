// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_firebase_ex1/models/custom_error.dart';

import '../../models/user_model.dart';

enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStatus homeStatus;
  final User user;
  final CustomError customError;
  HomeState({
    required this.homeStatus,
    required this.user,
    required this.customError,
  });

  factory HomeState.initial() {
    return HomeState(
      homeStatus: HomeStatus.initial,
      user: User.initialUser(),
      customError: CustomError(),
    );
  }

  @override
  List<Object> get props => [homeStatus, user, customError];

  @override
  bool get stringify => true;

  HomeState copyWith({
    HomeStatus? homeStatus,
    User? user,
    CustomError? customError,
  }) {
    return HomeState(
      homeStatus: homeStatus ?? this.homeStatus,
      user: user ?? this.user,
      customError: customError ?? this.customError,
    );
  }
}
