import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:state_notifier/state_notifier.dart';

import '../../repositories/auth_repository.dart';
import 'auth_state.dart';

// LocatorMixin 으로 다른 상태를 가져온다
class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  // AuthState 에 있는 unknown 값으로 초기화? 한다
  AuthProvider() : super(AuthState.unknown());

  // user 상태가 변경되면 authStatus 상태를 변경한다
  @override
  void update(Locator watch) {
    final user = watch<fbAuth.User?>();

    if (user != null) {
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: user,
      );
    } else {
      state = state.copyWith(authStatus: AuthStatus.unauthenticated);
    }
    print('authState: $state');
    super.update(watch);
  }

  // sign out
  void signout() async {
    // LocatorMixin 으로 다른 상태를 가져온다
    await read<AuthRepository>().singout();
  }
}
