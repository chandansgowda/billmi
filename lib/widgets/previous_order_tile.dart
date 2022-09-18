import 'package:flutter/material.dart';
import 'package:billmi/providers/order.dart';
import 'package:billmi/screens/mobile/previous_order_detail_screen.dart';
import 'package:billmi/utils/colors.dart';
import 'package:billmi/utils/rupee_extension.dart';

class PreviousOrderTile extends StatelessWidget {
  PreviousOrderTile({required this.previousOrderItem});

  final Order previousOrderItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PreviousOrderDetailsScreen.routeName,arguments: previousOrderItem);
      },
      child: Card(
        color: kPrimaryColour.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    previousOrderItem.cName,
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                  Text(
                    previousOrderItem.paymentMode,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${previousOrderItem.date.substring(0,10)}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text("${double.parse(previousOrderItem.price).toInt().inRupeesFormat()}",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
