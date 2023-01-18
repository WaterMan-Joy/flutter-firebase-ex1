import 'package:flutter_firebase_ex1/models/custom_error.dart';
import 'package:flutter_firebase_ex1/providers/users/users_state.dart';
import 'package:flutter_firebase_ex1/repositories/users_repositroy.dart';
import 'package:state_notifier/state_notifier.dart';

class UsersProvider extends StateNotifier<UsersState> with LocatorMixin {
  UsersProvider() : super(UsersState.initial());

  Future<void> getUserList() async {
    state = state.copyWith(usersStatus: UsersStatus.loading);

    try {
      // UsersRepository 에서 List User 형태로 데이터 coypwith해서 가져오기

      final users = await read<UsersRepositroy>().getUserList();

      state = state.copyWith(usersStatus: UsersStatus.loaded, users: users);
    } on CustomError catch (e) {
      state = state.copyWith(usersStatus: UsersStatus.error, customError: e);
    }
  }
}
