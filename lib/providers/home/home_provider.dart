import 'package:flutter_firebase_ex1/models/custom_error.dart';
import 'package:flutter_firebase_ex1/providers/home/home_state.dart';
import 'package:flutter_firebase_ex1/providers/providers.dart';
import 'package:flutter_firebase_ex1/repositories/profile_repository.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../models/user_model.dart';

// LocatorMixin 으로 다른 상태를 가져올 수 있게 만든다
class HomeProvider extends StateNotifier<HomeState> with LocatorMixin {
  // ProfileState 를 초기화 시킨다
  HomeProvider() : super(HomeState.initial());

  // void 타입으로 비동기로 uid 를 받아 ProfileRepository 의 void에 값을 넣는다
  Future<void> getProfile({required String uid}) async {
    // 함수 실행 즉시 스테이트를 loading 으로 업데이트 한다
    state = state.copyWith(homeStatus: HomeStatus.loading);

    try {
      // LocatorMixin 으로 다른 상태값을 가져온다
      final User user = await read<ProfileRepository>().getProfile(uid: uid);
      // state 값을 즉시 로딩완료로 상태를 바꾼다
      state = state.copyWith(homeStatus: HomeStatus.loaded, user: user);
    } on CustomError catch (e) {
      // error 가 캐치되면 스테이트 값을 error로 상태를 바꾼다
      state = state.copyWith(homeStatus: HomeStatus.error, customError: e);
    }
  }
}
