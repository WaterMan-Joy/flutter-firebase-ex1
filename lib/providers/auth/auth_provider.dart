// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter_firebase_ex1/providers/auth/auth_state.dart';
import 'package:flutter_firebase_ex1/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthState _state = AuthState.unknown();
  AuthState get state => _state;

  final AuthRepository authRepository;
  AuthProvider({
    required this.authRepository,
  });

  void update(fbAuth.User? user) {
    if (user != null) {
      _state =
          _state.copyWith(authStatus: AuthStatus.authenticated, user: user);
    } else {
      _state = _state.copyWith(authStatus: AuthStatus.unauthenticated);
    }
    print('auth state : $_state');
    notifyListeners();
  }

  void signout() async {
    await authRepository.singout();
  }
}
