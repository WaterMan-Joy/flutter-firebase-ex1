import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../utils/error_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String routeName = '/profile';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider profileProv;
  late final void Function() _removeListener;

  @override
  void initState() {
    super.initState();
    print('initState');
    profileProv = context.read<ProfileProvider>();
    _removeListener =
        profileProv.addListener(errorDialogListener, fireImmediately: false);
    _getProfile();
  }

  void _getProfile() {
    final String uid = context.read<fbAuth.User?>()!.uid;
    print('uid : $uid');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  void errorDialogListener(ProfileState state) {
    if (state.profileStatus == ProfileStatus.error) {
      print('errorDialog');
      errorDialog(context, state.customError);
    }
  }

  @override
  void dispose() {
    print('dispose');
    _removeListener();
    super.dispose();
  }

  Widget _buildProfile() {
    final profileState = context.watch<ProfileState>();

    if (profileState.profileStatus == ProfileStatus.initial) {
      return Container();
    } else if (profileState.profileStatus == ProfileStatus.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (profileState.profileStatus == ProfileStatus.error) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: profileState.user.profileImage,
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
    final profileState = context.watch<ProfileState>();
    print('build');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // Settings Page...
            },
            icon: Icon(Icons.settings),
          ),
        ],
        centerTitle: true,
        title: Text('${profileState.user.name}님의 프로필'),
      ),
      body: _buildProfile(),
    );
  }
}
