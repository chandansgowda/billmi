import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import '../../../providers/orders.dart';
import '../d_login_Screen.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    required FirebaseAuth auth,
    required this.storeName,
    required this.storeType,
  })
      : _auth = auth,
        super(key: key);

  final FirebaseAuth _auth;
  final String storeName, storeType;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
          padding: EdgeInsets.only(left: 5),
          child: Image.asset(
            "assets/icon.png",
          )),
      title: Text(
        "$storeName (Cat: $storeType)",
        style: TextStyle(color: Colors.blueGrey),
      ),
      actions: [
        Row(
          children: [
            SizedBox(width: 20),
            Text("${DateFormat('dd MMM yy').format(DateTime.now())}",
              style: TextStyle(fontSize: 25, color: Colors.blueGrey),),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: DigitalClock(
                digitAnimationStyle: Curves.ease,
                is24HourTimeFormat: true,
                areaDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                hourMinuteDigitTextStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                ),
              ),
            ),

          ],
        ),

        InkWell(
          onTap: () {
            _auth.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => DLoginScreen()),
                    (route) => false);
          },
          child: Row(
            children: [
              Icon(Icons.exit_to_app),
              Text("Logout"),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}