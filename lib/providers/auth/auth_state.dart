// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fbAuth.User? user;
  AuthState({
    required this.authStatus,
    this.user,
  });

  factory AuthState.unknown() {
    return AuthState(authStatus: AuthStatus.unknown);
  }

  // user 가 옵셔널임으로 List 안에 있는 타입을 옵셔널 타입으로
  @override
  List<Object?> get props => [authStatus, user];

  @override
  bool get stringify => true;

  AuthState copyWith({
    AuthStatus? authStatus,
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
