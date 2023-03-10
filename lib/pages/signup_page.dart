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
                child: const Text('????????????'),
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
                child: const Text('????????????????????? ????????????'),
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
      appBar: AppBar(title: Text('????????? ???????????? ????????????')),
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
                  child: Text('?????? ??????'),
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
                    labelText: '??????',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_add),
                    filled: true,
                  ),
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '????????? ???????????????';
                    }
                    if (value.trim().length < 2) {
                      return '????????? ?????? 2?????? ?????? ?????????';
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
                    labelText: '?????????',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '???????????? ???????????????';
                    }
                    if (!isEmail(value)) {
                      return '???????????? ???????????????';
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
                    labelText: '????????????',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '??????????????? ???????????????';
                    }
                    if (value.trim().length < 6) {
                      return '??????????????? ???????????????';
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
                    labelText: '???????????? ??????',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return '???????????? ????????? ???????????????';
                    }
                    if (value != _passwprdController.text) {
                      return '??????????????? ???????????????';
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
                          ? '???????????? ???'
                          : '????????????'),
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
        print('????????? ????????????');
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
        print('????????? ????????????');
      }
    }
  }
}
