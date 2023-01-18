import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_ex1/providers/users/users_provider.dart';
import 'package:flutter_firebase_ex1/providers/users/users_state.dart';
import 'package:flutter_firebase_ex1/utils/error_dialog.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  static const String routeName = '/userList';

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late final UsersProvider usersProvider;
  late final void Function() _removeListener;

  void _getUserList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersProvider>().getUserList();
    });
  }

  void errorUserListDialogListener(UsersState state) {
    if (state.usersStatus == UsersStatus.error) {
      print('User List ErrorDialog');
      errorDialog(context, state.customError);
    }
  }

  @override
  void initState() {
    super.initState();
    print('user_list_page initState');
    usersProvider = context.read<UsersProvider>();
    _removeListener = usersProvider.addListener(errorUserListDialogListener,
        fireImmediately: false);
    _getUserList();
  }

  @override
  void dispose() {
    print('user_list_page dispose');
    _removeListener;
    super.dispose();
  }

  Widget _buildUserList() {
    final userListState = context.watch<UsersState>();

    // initial
    if (userListState.usersStatus == UsersStatus.initial) {
      return Container(
        child: Text('유저 리스트 정보 초기화'),
      );
    }
    // loading
    else if (userListState.usersStatus == UsersStatus.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // error
    else if (userListState.usersStatus == UsersStatus.error) {
      return Center(
        child: Row(
          children: [
            Image.asset(
              'assets/images/error.png',
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '유저 정보 불러오기 실패\n다시 실행해 주세요',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      child: ListView.builder(
        itemCount: userListState.users.length,
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userListState.users[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    userListState.users[index].email,
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              subtitle: Text(
                  '랭크 ${userListState.users[index].lank} - 포인트 ${userListState.users[index].point}'),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // 채팅 페이지
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.read<UsersProvider>().getUserList(),
            icon: Icon(Icons.restart_alt),
          ),
        ],
        centerTitle: true,
        title: Text('유저 리스트'),
      ),
      body: _buildUserList(),
    );
  }
}
