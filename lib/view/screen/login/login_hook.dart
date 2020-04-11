import 'dart:async';

import 'package:auth/model/login.dart';
import 'package:auth/view/screen/login/code_step.dart';
import 'package:auth/view/screen/login/email_step.dart';
import 'package:auth/view/screen/utils/error_message.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginHook extends HookWidget {
  final LoginModel model;

  LoginHook({this.model});

  void createSnackBar(BuildContext context, String message) {
    Flushbar(
      duration: Duration(seconds: 3),
      title: 'Petit soucis',
      message: message,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    // POUR LES SIDES EFFECT ! 😉
    useEffect(
      () {
        print('model.error ${model.error}');
        if (model.error != LoginError.None) {
          scheduleMicrotask(() {
            createSnackBar(context, ErrorMessage.loginError(model.error));
          });
        }
        return null;
      },
      [model.error],
    );

    // De la logic UI seulement ! 😇
    if (model.state == LoginState.NeedCode) {
      return CodeStep(model: model);
    }
    return EmailStep(model: model);
  }
}