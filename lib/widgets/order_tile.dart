//Not in Use

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'order_quantity_popup.dart';

class OrderTile extends StatelessWidget {
  String name;
  int price;
  int quantity;
  IconData iconStyle;
  OrderTile(
      {required this.name,
        required this.price,
        required this.quantity,
        required this.iconStyle});
  final TextEditingController qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                OrderQuantityCard(sn: 100, name: name, price: price));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kPrimaryColour, width: 2)),
        height: 90,
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(2),
                          topLeft: Radius.circular(2)),
                      color: kPrimaryColour,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              iconStyle,
                              size: 28,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            child: Text(
                              name,
                              style:
                              TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2),
                        ),
                        color: kPrimaryColour.withOpacity(0.6),
                      ),
                      child: Center(
                          child: Text(
                            " Available Qty : " + quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [.5, .5],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            kPrimaryColour.withOpacity(0.6),
                            Colors.transparent, // top Right part
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rs." + price.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Sample Data
// ListView(
// padding: EdgeInsets.only(top: 8),
// children: [
// OrderTile(
// name: "Redmi note 11 pro",
// iconStyle: Icons.phone_android,
// price: 99999,
// quantity: 20,
// ),
// SizedBox(
// height: 5,
// ),
// OrderTile(
// name: "Redmi Simplx 2",
// price: 520000,
// quantity: 10,
// iconStyle: Icons.phone_android),
// SizedBox(
// height: 5,
// ),
// OrderTile(
// name: "Xiaomi Smart TV",
// price: 1520000,
// quantity: 3,
// iconStyle: Icons.tv),
// SizedBox(
// height: 5,
// ),
// ],
// ),