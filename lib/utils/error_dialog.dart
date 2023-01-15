import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ex1/models/custom_error.dart';

Future errorDialog(BuildContext context, CustomError e) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(e.code),
          content: Text('${e.plugin}\n${e.errorMsg}'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  } else {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(e.code),
            content: Text('${e.plugin}\n${e.errorMsg}'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK')),
            ],
          );
        });
  }
}
