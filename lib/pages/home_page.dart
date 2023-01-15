import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_ex1/pages/profile_page.dart';
import 'package:flutter_firebase_ex1/providers/auth/auth_provider.dart';
import 'package:flutter_firebase_ex1/providers/signin/signin_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('어서오세요 **님'),
          actions: [
            IconButton(
              onPressed: () => context.read<AuthProvider>().signout(),
              icon: Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) {
                    return ProfilePage();
                  }),
                );
              },
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('홈페이지'),
            ],
          ),
        ),
      ),
    );
  }
}
