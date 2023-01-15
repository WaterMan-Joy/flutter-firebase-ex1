import 'package:state_notifier/state_notifier.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';
import 'signin_state.dart';

// LocatorMixin 은 다른 상태를 가져와서 사용 할 수 있게 한다
class SigninProvider extends StateNotifier<SigninState> with LocatorMixin {
  // SigninState 를 초기화 한다
  SigninProvider() : super(SigninState.initial());

  Future<void> signin({required String email, required String password}) async {
    // state 에 현재의 상태를 업데이트 한다 submitting
    state = state.copyWith(signinStatus: SigninStatus.submitting);

    try {
      // LocatorMixin 으로 다른 상태를 가져와서 try 한다
      await read<AuthRepository>().signin(email: email, password: password);
      // 로그인 하고 상태를 업데이트 한다 success
      state = state.copyWith(signinStatus: SigninStatus.success);
    } on CustomError catch (e) {
      // CustomError 모델의 state 업데이트 한다 error
      state = state.copyWith(signinStatus: SigninStatus.error, customError: e);
      rethrow;
    }
  }
}
