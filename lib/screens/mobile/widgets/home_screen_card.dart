import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class HomeScreenCard extends StatelessWidget {
  IconData icon;
  String text;
  HomeScreenCard({required this.icon,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          height: MediaQuery.of(context).size.height*0.26,
          width: MediaQuery.of(context).size.width/2.2,
          decoration: BoxDecoration(
              color: kPrimaryBackgroundColour,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),
                          child: Icon(icon, size: MediaQuery.of(context).size.height*0.12,),
                        ),
                      ],
                    ),
                  ),
                ),
                MediaQuery(
                    data: MediaQueryData(textScaleFactor: 1.2),
                    child: Container(
                        decoration: BoxDecoration(
                            color: kPrimaryColour,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.015),
                          child: Text(text, style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.06 ),textAlign: TextAlign.center,),
                        )))
              ],
            ),
          ),
        )
    );
  }
}