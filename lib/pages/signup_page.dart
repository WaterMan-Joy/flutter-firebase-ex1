import 'package:flutter/material.dart';
import 'package:flutter_firebase_ex1/models/custom_error.dart';
import 'package:flutter_firebase_ex1/providers/signup/signup_provider.dart';
import 'package:flutter_firebase_ex1/providers/signup/signup_state.dart';
import 'package:flutter_firebase_ex1/utils/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _name, _email, _password;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  final _passwprdController = TextEditingController();

  //Camera
  XFile? _pickedFile;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    form.save();
    print('***** name : $_name, email : $_email, password : $_password *****');
    try {
      await context
          .read<SignupProvider>()
          .signup(name: _name!, email: _email!, password: _password!);
    } on CustomError catch (e) {
      errorDialog(context, e);
      print('error dialog');
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupState = context.watch<SignupState>();

    final _imageSize = MediaQuery.of(context).size.width / 4;

    _showBottomSheet() {
      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => _getCameraImage(),
                child: const Text('사진찍기'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => _getPhotoLibraryImage(),
                child: const Text('라이브러리에서 불러오기'),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
      );
    }

    // TODO: MAIN VIEW
    return Scaffold(
      appBar: AppBar(title: Text('로그인 화면으로 돌아가기')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: ListView(
              reverse: true,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                // TODO: CAMERA
                if (_pickedFile == null)
                  Container(
                    constraints: BoxConstraints(
                      minHeight: _imageSize,
                      minWidth: _imageSize,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _showBottomSheet();
                      },
                      child: Center(
                        child: Icon(
                          Icons.account_circle,
                          size: _imageSize,
                        ),
                      ),
                    ),
                  )
                else
                  Center(
                    child: Container(
                      width: _imageSize,
                      height: _imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary),
                        image: DecorationImage(
                            image: FileImage(
                              File(_pickedFile!.path),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                // TODO: Selected Photo
                ElevatedButton(
                  onPressed: () => _showBottomSheet(),
                  child: Text('사진 선택'),
                ),
                // Image.asset(
                //   'assets/images/flutter_logo.png',
                //   width: 250,
                //   height: 250,
                // ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: '이름',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_add),
                    filled: true,
                  ),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '이름을 입력하세요';
                    }
                    if (value.trim().length < 2) {
                      return '이름은 최소 2글자 이상 입니다';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    _name = newValue;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '이메일을 입력하세요';
                    }
                    if (!isEmail(value)) {
                      return '이메일을 확인하세요';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    _email = newValue;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // TODO: password
                TextFormField(
                  controller: _passwprdController,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '비밀번호를 입력하세요';
                    }
                    if (value.trim().length < 6) {
                      return '비밀번호를 확인하세요';
                    }
                    return null;
                  },
                  onSaved: (String? newValue) {
                    _password = newValue;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // TODO: password
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: '비밀번호 확인',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '비밀번호 확인을 입력하세요';
                    }
                    if (value != _passwprdController.text) {
                      return '비밀번호를 확인하세요';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                  onPressed: signupState.signupStatus == SignupStatus.submitting
                      ? null
                      : _submit,
                  child: Text(
                      signupState.signupStatus == SignupStatus.submitting
                          ? '회원가입 중'
                          : '회원가입'),
                ),
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }

  _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        print('camera path : ${_pickedFile!.path}');
        print('camera name : ${_pickedFile!.name}');
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  // TODO: REOMOVE
  _getRemovePhoto() {}

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        print('phote path : ${_pickedFile!.path}');
        print('phote name : ${_pickedFile!.name}');
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }
}
