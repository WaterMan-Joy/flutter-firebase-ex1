// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_firebase_ex1/models/custom_error.dart';

enum SigninStatus {
  ititial,
  submitting,
  success,
  error,
}

class SigninState extends Equatable {
  final SigninStatus signinStatus;
  final CustomError customError;
  SigninState({
    required this.signinStatus,
    required this.customError,
  });

  factory SigninState.initial() {
    return SigninState(
      signinStatus: SigninStatus.ititial,
      customError: CustomError(),
    );
  }

  @override
  List<Object> get props => [signinStatus, customError];

  @override
  bool get stringify => true;

  SigninState copyWith({
    SigninStatus? signinStatus,
    CustomError? customError,
  }) {
    return SigninState(
      signinStatus: signinStatus ?? this.signinStatus,
      customError: customError ?? this.customError,
    );
  }
}
