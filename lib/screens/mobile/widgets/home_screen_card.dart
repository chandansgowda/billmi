import 'package:flutter/material.dart';import 'package:billmi/utils/colors.dart';

class MHomeScreenCard extends StatelessWidget {
  IconData icon;
  String text;
  MHomeScreenCard({required this.icon,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        height: MediaQuery.of(context).size.height/3.5,
        width: MediaQuery.of(context).size.width/2.2,
        decoration: BoxDecoration(
          color: kPrimaryColour,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon, size: 100,),
              Text(text, style: TextStyle(color: Colors.white,fontSize: 25 ),textAlign: TextAlign.center,)
            ],
          ),
        ),
      )
    );
  }
}