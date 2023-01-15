import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_ex1/pages/home_page.dart';
import 'package:flutter_firebase_ex1/pages/signin_page.dart';
import 'package:flutter_firebase_ex1/providers/auth/auth_provider.dart';
import 'package:flutter_firebase_ex1/providers/auth/auth_state.dart';
import 'package:provider/provider.dart';

class Splashpage extends StatelessWidget {
  const Splashpage({super.key});
  static const String royyuteName = '/';

  @override
  Widget build(BuildContext context) {
    // 현재 계정이 로그인 되어 있냐 없냐 스테이트;
    final authStatus = context.watch<AuthState>();

    if (authStatus.authStatus == AuthStatus.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, HomePage.routeName);
      });
    } else if (authStatus.authStatus == AuthStatus.unauthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, SignInPage.routeName);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Splash Page'),
      ),
      body: Center(),
    );
  }
}
