// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_firebase_ex1/models/custom_error.dart';

enum SignupStatus {
  ititail,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  final SignupStatus signupStatus;
  final CustomError customError;
  SignupState({
    required this.signupStatus,
    required this.customError,
  });

  factory SignupState.initial() {
    return SignupState(
        signupStatus: SignupStatus.ititail, customError: CustomError());
  }

  @override
  List<Object> get props => [signupStatus, customError];

  @override
  bool get stringify => true;

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? customError,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      customError: customError ?? this.customError,
    );
  }
}
