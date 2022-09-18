import 'package:flutter/material.dart';
import 'package:billmi/utils/rupee_extension.dart';
import 'package:billmi/widgets/order_quantity_popup.dart';
import 'package:billmi/utils/colors.dart';

class InventoryCardItem extends StatelessWidget {
  String name;
  int sn;
  int price;
  int available;
  String imageUrl;
  bool isClickable;

  InventoryCardItem(
      {required this.name,
      required this.sn,
      required this.price,
      required this.available,
      required this.imageUrl,
      required this.isClickable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isClickable && available>0) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2.5,
                  color: Colors.transparent,
                  child: OrderQuantityCard(sn: sn, name: name, price: price)));
          // showDialog(
          //     context: context,
          //     builder: (_) {
          //       return AlertDialog(
          //         contentPadding: EdgeInsets.all(0),
          //         content: Container(
          //           width: MediaQuery.of(context).size.width/2,
          //             height: MediaQuery.of(context).size.width/2.5,
          //             color: Colors.transparent,
          //             child:
          //                 OrderQuantityCard(sn: sn, name: name, price: price)),
          //       );
          //     });
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: kPrimaryColour.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: 110,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("$name"), Text("$sn")],
              ),
              Divider(
                thickness: 2,
                color: kPrimaryColour.withOpacity(0.5),
                height: 2,
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 55,
                    child: Image.network("$imageUrl"),
                  ),
                  Expanded(
                    child: Container(
                      width: 50,
                      height: 55,
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Availability"),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text("${(available>0) ? "In-Stock" : "Out-of-stock"}")
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Price"),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text("${price.inRupeesFormat()}/-")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
