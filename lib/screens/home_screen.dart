import 'package:flutter/material.dart';

import 'desktop/d_home_Screen.dart';
import 'mobile/m_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth>=600){
        return DHomeScreen();
      }
      else{
        return MHomeScreen();
      }
    },);
  }
}
