import 'package:flutter/material.dart';
import 'package:billmi/utils/rupee_extension.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../providers/cart.dart';

class OrderDetailsPreview extends StatefulWidget {
  OrderDetailsPreview({
    Key? key,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController mobileController,
    required TextEditingController addressController,
    required this.cartItems,
    required this.totalCartValue,
  }) : _nameController = nameController, _emailController = emailController, _mobileController = mobileController, _addressController = addressController, super(key: key);

  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _mobileController;
  final TextEditingController _addressController;
  final List<CartItem> cartItems;
  final int totalCartValue;

  @override
  State<OrderDetailsPreview> createState() => _OrderDetailsPreviewState();
}

class _OrderDetailsPreviewState extends State<OrderDetailsPreview> {
  String deliveryType = "Store Pickup";


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(5),
              },
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "${widget._nameController.text}",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "${widget._emailController.text}",
                        style: TextStyle(
                            fontSize: 15),
                        textAlign: TextAlign
                            .center,
                      )),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Text(
                        "Mobile",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "${widget._mobileController.text}",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "${widget._addressController.text}",
                        style: TextStyle(
                            fontSize: 15),
                        textAlign: TextAlign
                            .center,
                      )),
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
              },
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Text(
                        "Product",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "Price",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "Qty",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                ]),
                ...widget.cartItems
                    .map((item) {
                  return TableRow(
                      children: [
                        TableCell(
                            child: Text(
                              "${item.name}",
                              textAlign:
                              TextAlign
                                  .center,
                            )),
                        TableCell(
                            child: Text(
                              "Rs. ${item.price}",
                              textAlign:
                              TextAlign
                                  .center,
                            )),
                        TableCell(
                            child: Text(
                              "${item.quantity}",
                              textAlign:
                              TextAlign
                                  .center,
                            )),
                      ]);
                }).toList(),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Text(
                        "Subtotal",
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "Rs ${widget.totalCartValue}",
                        textAlign: TextAlign
                            .center,
                      )),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Text(
                        "Tax (18%)",
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "Rs ${(widget.totalCartValue * (0.18)).truncate()}",
                        textAlign: TextAlign
                            .center,
                      )),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Text(
                        "Total Due",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                  TableCell(
                      child: Text(
                        "${((widget.totalCartValue * 1.18).truncate()).inRupeesFormat()}",
                        style: TextStyle(
                            fontSize: 20),
                        textAlign: TextAlign
                            .center,
                      )),
                ]),
              ],
            ),
          ),
          SizedBox(height: 25,),
          ToggleSwitch(
            minWidth: 150,
            initialLabelIndex: 0,
            cornerRadius: 20.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: ['In-Store', 'Home'],
            icons: [Icons.store, Icons.home],
            activeBgColors: [
              [Colors.deepOrange],
              [Colors.deepOrange]
            ],
            onToggle: (index) {
              deliveryType = (index == 0) ? "Store Pickup" : "Home";
            },
          ),

        ],
      ),
    );
  }
}