// import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';
import 'signup_state.dart';

// LocatorMixin 은 다른 스테이트를 가져와서 사용할 수 있게한다 ex) AuthRepository
class SignupProvider extends StateNotifier<SignupState> with LocatorMixin {
  SignupProvider() : super(SignupState.initial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(signupStatus: SignupStatus.submitting);

    try {
      await read<AuthRepository>()
          .signup(name: name, email: email, password: password);

      state = state.copyWith(signupStatus: SignupStatus.success);
    } on CustomError catch (e) {
      state = state.copyWith(signupStatus: SignupStatus.error, customError: e);

      rethrow;
    }
  }
}
