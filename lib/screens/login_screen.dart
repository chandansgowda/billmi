import 'package:flutter/material.dart';
import 'desktop/d_login_Screen.dart';
import 'mobile/m_login_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName='/login-screen';
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 600) {
          return DLoginScreen();
        } else {
          return MLoginScreen();
        }
      },
    );
  }
}
