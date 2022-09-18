import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class OrderQuantityCard extends StatefulWidget {
  int sn;
  String name;
  int price;

  OrderQuantityCard({
    required this.sn,
    required this.name,
    required this.price,
  });

  @override
  State<OrderQuantityCard> createState() => _OrderQuantityCardState();
}

class _OrderQuantityCardState extends State<OrderQuantityCard> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width/3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(12.0))),
                    child: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(12.0))),
                      child: Center(
                        child: Text(
                          "QUANTITY",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 90,
                width: double.infinity,
                color: Colors.orangeAccent.shade100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        widget.name,
                        style: TextStyle(fontSize: 25),
                      ),
                      height: 40,
                    ),
                    // Container(
                    //
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           child: Text(
                    //             "Details:",
                    //             style: TextStyle(fontSize: 20),
                    //           ),
                    //           width: 80,
                    //         ),
                    //         Expanded(
                    //             child: Container(
                    //           height: 100,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //
                    //                 Container(
                    //                   child: Text(
                    //                     "8BG RAM",
                    //                     style: TextStyle(fontSize: 20),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   child: Text(
                    //                     "126GB Storage",
                    //                     style: TextStyle(fontSize: 20),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   child: Text(
                    //                     "Snapdragon Processor",
                    //                     style: TextStyle(fontSize: 20),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ))
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                color: Colors.orangeAccent.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "Quantity",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: RawMaterialButton(
                                    shape: CircleBorder(),
                                    child: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity != 0) {
                                          quantity--;
                                        }
                                      });
                                    },
                                    elevation: 6.0,
                                    constraints: BoxConstraints.tightFor(
                                      width: 56.0,
                                      height: 56.0,
                                    ),
                                    fillColor: Colors.white70,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Text("$quantity",
                                      style: TextStyle(fontSize: 20)),
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: RawMaterialButton(
                                    shape: CircleBorder(),
                                    child: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    elevation: 6.0,
                                    constraints: BoxConstraints.tightFor(
                                      width: 56.0,
                                      height: 56.0,
                                    ),
                                    fillColor: Colors.white70,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 40,
                      // ),
                      // Container(
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         child: Text(
                      //           " Colors",
                      //           style: TextStyle(fontSize: 20),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Row(
                      //           children: [
                      //             RawMaterialButton(
                      //               shape: CircleBorder(),
                      //               child: Icon(Icons.adjust_rounded),
                      //               onPressed: () {},
                      //               elevation: 6.0,
                      //               constraints: BoxConstraints.tightFor(
                      //                 width: 25.0,
                      //                 height: 25.0,
                      //               ),
                      //               fillColor: Colors.red,
                      //             ),
                      //             RawMaterialButton(
                      //               shape: CircleBorder(),
                      //               child: Icon(Icons.adjust_rounded),
                      //               onPressed: () {},
                      //               elevation: 6.0,
                      //               constraints: BoxConstraints.tightFor(
                      //                 width: 25.0,
                      //                 height: 25.0,
                      //               ),
                      //               fillColor: Colors.black,
                      //             ),
                      //             RawMaterialButton(
                      //               shape: CircleBorder(),
                      //               child: Icon(Icons.adjust_rounded),
                      //               onPressed: () {},
                      //               elevation: 6.0,
                      //               constraints: BoxConstraints.tightFor(
                      //                 width: 25.0,
                      //                 height: 25.0,
                      //               ),
                      //               fillColor: Colors.blue,
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepOrangeAccent, blurRadius: 10.0)
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0)),
                      color: Colors.orange),
                  height: 60,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (quantity > 0) {
                        final newItem = CartItem(
                            sn: widget.sn,
                            name: widget.name,
                            price: widget.price,
                            quantity: quantity);
                        Provider.of<Cart>(context, listen: false)
                            .addItem(newItem);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Add To Cart"),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.white)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
