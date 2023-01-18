import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ex1/pages/profile_page.dart';
import 'package:flutter_firebase_ex1/pages/user_list_page.dart';
import 'package:flutter_firebase_ex1/providers/providers.dart';
import 'package:flutter_firebase_ex1/providers/users/users_provider.dart';
import 'package:flutter_firebase_ex1/providers/users/users_state.dart';
import 'package:flutter_firebase_ex1/utils/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late final UsersProvider usersProv;
  // late final void Function() _removeListener;
  late final ProfileProvider profileProv;
  late final void Function() _removeProfileListener;

  @override
  void initState() {
    super.initState();
    print('initState');
    // 유저목록 프로바이더
    // usersProv = context.read<UsersProvider>();
    // _removeListener =
    //     usersProv.addListener(errorDialogListener, fireImmediately: false);
    // 로그인된 유저 프로바이더
    profileProv = context.read<ProfileProvider>();
    _removeProfileListener = profileProv.addListener(errorProfileDialogListener,
        fireImmediately: false);
    // _getUsers();
    _getUser();
  }

  void _getUser() {
    // 홈 화면에 계정 이름 나타내기
    final String uid = context.read<fbAuth.User?>()!.uid;
    print('uid : $uid');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  // void _getUsers() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<UsersProvider>().getUserList();
  //   });
  // }

  // void errorDialogListener(UsersState state) {
  //   if (state.usersStatus == UsersStatus.error) {
  //     print('errorDialog');
  //     errorDialog(context, state.customError);
  //   }
  // }

  void errorProfileDialogListener(ProfileState state) {
    if (state.profileStatus == UsersStatus.error) {
      print('Profile ErrorDialog');
      errorDialog(context, state.customError);
    }
  }

  @override
  void dispose() {
    // _removeListener;
    _removeProfileListener;
    super.dispose();
  }

  // Widget _buildUsers() {
  //   final usersState = context.watch<UsersState>();

  //   if (usersState.usersStatus == UsersStatus.initial) {
  //     return Container(
  //       child: Text('유저 정보 초기화'),
  //     );
  //   } else if (usersState.usersStatus == UsersStatus.loading) {
  //     return Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   } else if (usersState.usersStatus == UsersStatus.error) {
  //     return Center(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Image.asset(
  //             'assets/images/error.png',
  //             width: 75,
  //             height: 75,
  //             fit: BoxFit.cover,
  //           ),
  //           SizedBox(width: 20.0),
  //           Text(
  //             '유저 정보 불러오기 실패\n다시 실행해 주세요',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: 20.0,
  //               color: Colors.red,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //   return Center(
  //     child: ListView.builder(
  //       itemCount: usersState.users.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Column(
  //           children: [
  //             Card(
  //               child: ListTile(
  //                 leading: Text('${usersState.users[index].name}'),
  //                 title: Text('${usersState.users[index].email}'),
  //                 subtitle: Text(
  //                     '점수 ${usersState.users[index].lank} - 포인트 ${usersState.users[index].point}'),
  //                 trailing: IconButton(
  //                   onPressed: () {
  //                     // 채팅 창으로 넘어가기
  //                   },
  //                   icon: Icon(Icons.send),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileState>();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // automaticallyImplyLeading: false,
          title: Text('안녕하세요 ${profileState.user.name}님'),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, ProfilePage.routeName),
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name - ${profileState.user.name}'),
                    Text('Email - ${profileState.user.email}'),
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: profileState.user.profileImage,
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('유저 리스트'),
                  onTap: () =>
                      Navigator.pushNamed(context, UserListPage.routeName),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('설정'),
                  onTap: () {
                    // 설정 페이지
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('로그아웃'),
                  leading: Icon(Icons.logout),
                  selected: true,
                  onTap: () => context.read<AuthProvider>().signout(),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.close),
                  title: Text('닫기'),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
        body: Center(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 포스트 업로드 페이지로 이동
          },
          child: Icon(Icons.add_card),
        ),
      ),
    );
  }
}
