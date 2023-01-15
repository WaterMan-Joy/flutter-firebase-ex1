import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../utils/error_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // initstate 에서 값을 가져올것이기 때문에 late 를 사용한다
  late final ProfileProvider profileProv;
  // 마찬가지로 initstate 와 dispose에서 사용할 것이기 때문에 late 사용
  late final void Function() _removeListener;

  @override
  void initState() {
    super.initState();
    print('initState');
    // ProfileProvider 를 read 한다
    profileProv = context.read<ProfileProvider>();
    // error 함수를 만들어 state 가 error 일 경우 errorDialog 를 표시한다
    _removeListener =
        profileProv.addListener(errorDialogListener, fireImmediately: false);
    // init state 에서 유저 uid를 가져온다
    _getProfile();
  }

  // 유저 정보 uid를 가져오는 함수 init state 에서 사용하기 때문에 뷰 가 순서대로 로드되야함
  void _getProfile() {
    final String uid = context.read<fbAuth.User?>()!.uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  // init state 에서 로드 될때 error 가 발생한다면 errorDialog 를 표시한다
  void errorDialogListener(ProfileState state) {
    if (state.profileStatus == ProfileStatus.error) {
      print('errorDialog');
      errorDialog(context, state.customError);
    }
  }

  @override
  void dispose() {
    print('dispose');
    // 뷰가 dispose 될 때 profileProvider 를 dispose 한다
    _removeListener();
    super.dispose();
  }

  Widget _buildProfile() {
    // profile 상태를 watch 한다
    final profileState = context.watch<ProfileState>();

    // profile state 가 initial 이라면
    if (profileState.profileStatus == ProfileStatus.initial) {
      return Container();
    }
    // profile state 가 loading 이라면
    else if (profileState.profileStatus == ProfileStatus.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // profile state 가 error 라면 에러 뷰 표시
    else if (profileState.profileStatus == ProfileStatus.error) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.png',
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 20.0),
            Text(
              'Ooops!\nTry again',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }
    // 앞의 전재 조건을 모두 거친 다음 뷰를 표시
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: profileState.user.profileImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- id: ${profileState.user.id}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  '- name: ${profileState.user.name}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  '- email: ${profileState.user.email}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  '- point: ${profileState.user.point}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  '- rank: ${profileState.user.lank}',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _buildProfile(),
    );
  }
}
