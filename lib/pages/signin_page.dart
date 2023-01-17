import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_ex1/models/custom_error.dart';
import 'package:flutter_firebase_ex1/pages/signup_page.dart';
import 'package:flutter_firebase_ex1/providers/signin/signin_provider.dart';
import 'package:flutter_firebase_ex1/providers/signin/signin_state.dart';
import 'package:flutter_firebase_ex1/utils/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const String routeName = '/signin';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    print('email : $_email, password : $_password');

    try {
      await context
          .read<SigninProvider>()
          .signin(email: _email!, password: _password!);
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signinStatus = context.watch<SigninState>();

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Image.asset(
                      'assets/images/flutter_logo.png',
                      width: 250,
                      height: 250,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return '이메일을 입력하세요';
                        }
                        if (!isEmail(value.trim())) {
                          return '이메일을 다시 확인하세요';
                        }
                        return null;
                      },
                      onSaved: (String? newValue) => _email = newValue,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "비밀번호를 입력하세요";
                        }
                        if (value.trim().length < 6) {
                          return '비밀번호는 6자리보다 커야 합니다';
                        }
                        return null;
                      },
                      onSaved: (String? newValue) => _password = newValue,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed:
                          signinStatus.signinStatus == SigninStatus.submitting
                              ? null
                              : _submit,
                      child: Text(
                        signinStatus.signinStatus == SigninStatus.submitting
                            ? '로딩중'
                            : '로그인',
                      ),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed:
                          signinStatus.signinStatus == SigninStatus.submitting
                              ? null
                              : () => Navigator.pushNamed(
                                  context, SignUpPage.routeName),
                      child: Text('회원가입'),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
