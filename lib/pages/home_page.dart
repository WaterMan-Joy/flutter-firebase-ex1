import 'package:flutter/material.dart';
import 'package:flutter_firebase_ex1/pages/profile_page.dart';
import 'package:flutter_firebase_ex1/providers/providers.dart';
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
  late final HomeProvider homeProv;
  late final void Function() _removeListener;

  @override
  void initState() {
    super.initState();
    print('initState');
    homeProv = context.read<HomeProvider>();
    _removeListener =
        homeProv.addListener(errorDialogListener, fireImmediately: false);
    _getProfile();
  }

  void _getProfile() {
    final String uid = context.read<fbAuth.User?>()!.uid;
    print('uid : $uid');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().getProfile(uid: uid);
    });
  }

  void errorDialogListener(HomeState state) {
    if (state.homeStatus == HomeStatus.error) {
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
    final homeState = context.watch<HomeState>();

    if (homeState.homeStatus == HomeStatus.initial) {
      return Container(
        child: Text('초기화'),
      );
    } else if (homeState.homeStatus == HomeStatus.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (homeState.homeStatus == HomeStatus.error) {
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
              '다시 실행해 주세요',
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
    return Center(
      child: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('${homeState.user.name}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('One-line ListTile'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeState>();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // automaticallyImplyLeading: false,
          title: Text('안녕하세요 ${homeState.user.name}님'),
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
                    Text('Name - ${homeState.user.name}'),
                    Text('Email - ${homeState.user.email}'),
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: homeState.user.profileImage,
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('로그아웃'),
                leading: Icon(Icons.logout),
                selected: true,
                onTap: () => context.read<AuthProvider>().signout(),
              ),
              Card(
                child: ListTile(
                  title: Text('설정'),
                  onTap: () {
                    // 설정 페이지
                  },
                ),
              ),
              AboutListTile(
                applicationName: '앱 정보',
                applicationIcon: FlutterLogo(),
                applicationVersion: '1.0',
                applicationLegalese: 'Free',
              ),
              Container(
                height: 50.0,
                child: ElevatedButton(
                  child: Text('닫기'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        body: _buildProfile(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // add post
          },
          child: Icon(Icons.add_card),
        ),
      ),
    );
  }
}
