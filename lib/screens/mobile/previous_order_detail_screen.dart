import 'dart:io';

import 'package:flutter/material.dart';
import 'package:billmi/providers/order.dart';
import 'package:billmi/utils/colors.dart';

class PreviousOrderDetailsScreen extends StatefulWidget {
  static const routeName="/-m-previous-order-details-screen";

  @override
  State<PreviousOrderDetailsScreen> createState() => _PreviousOrderDetailsScreenState();
}

class _PreviousOrderDetailsScreenState extends State<PreviousOrderDetailsScreen> {


  @override
  Widget build(BuildContext context) {
    final previousOrderItem = ModalRoute.of(context)?.settings.arguments as Order;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColour,
        title: Text("Order Details",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryBackgroundColour,
            borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("${previousOrderItem.cName}",style: TextStyle(color: kPrimaryColour,fontSize: 35),),
                      Divider(thickness: 1,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(previousOrderItem.cEmail,style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
                              SizedBox(height: 5,),
                              Text(previousOrderItem.cPhone.toString(),style: TextStyle(fontSize: 30),),
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text("Payment",style: TextStyle(fontSize: 30)),
                                  Divider(thickness: 1,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: (Platform.isWindows) ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Status : ${previousOrderItem.paymentStatus?"Paid":"Not Paid"}",style: TextStyle(fontSize: 25)),
                                        Text("Mode : "+previousOrderItem.paymentMode,style: TextStyle(fontSize: 25)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text("Address",style: TextStyle(fontSize: 30)),
                              Divider(thickness: 1,),
                              Text("${previousOrderItem.cAddress}",style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text("Products",style: TextStyle(fontSize: 30)),
                              Divider(thickness: 1,),
                              Text("${previousOrderItem.items}",style: TextStyle(fontSize: 25)),
                              SizedBox(height: 10,),
                              Text("TODO: Products have to be determined using the ID", textAlign:TextAlign.center,style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   height: MediaQuery.of(context).size.height*0.3,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10)
                      //   ),
                      //   child: SingleChildScrollView(
                      //       child: DataTable(
                      //         columns: const <DataColumn>[
                      //           DataColumn(
                      //             label: Expanded(
                      //               child: Text(
                      //                 'Product',
                      //                 style: TextStyle(
                      //                     fontStyle: FontStyle.italic, fontSize: 20),
                      //               ),
                      //             ),
                      //           ),
                      //           DataColumn(
                      //             label: Expanded(
                      //               child: Text(
                      //                 'Quantity',
                      //                 style: TextStyle(
                      //                     fontStyle: FontStyle.italic, fontSize: 20),
                      //               ),
                      //             ),
                      //           ),
                      //           DataColumn(
                      //             label: Expanded(
                      //               child: Text(
                      //                 'Price',
                      //                 style: TextStyle(
                      //                     fontStyle: FontStyle.italic, fontSize: 20),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //         rows: const <DataRow>[
                      //           DataRow(
                      //             cells: <DataCell>[
                      //               DataCell(
                      //                 Text(
                      //                   'Redmi note 9 pro',
                      //                   style: TextStyle(fontSize: 18),
                      //                 ),
                      //               ),
                      //               DataCell(Text('2', style: TextStyle(fontSize: 18))),
                      //               DataCell(Text('3516165', style: TextStyle(fontSize: 18))),
                      //             ],
                      //           ),
                      //           DataRow(
                      //             cells: <DataCell>[
                      //               DataCell(Text('Redmi note 9 pro 125GB',
                      //                   style: TextStyle(fontSize: 18))),
                      //               DataCell(Text('43', style: TextStyle(fontSize: 18))),
                      //               DataCell(Text('6161916', style: TextStyle(fontSize: 18))),
                      //             ],
                      //           ),
                      //           DataRow(
                      //             cells: <DataCell>[
                      //               DataCell(Text('Redmi note 9 pro TV ',
                      //                   style: TextStyle(fontSize: 18))),
                      //               DataCell(Text('27', style: TextStyle(fontSize: 18))),
                      //               DataCell(Text('6698498', style: TextStyle(fontSize: 18))),
                      //             ],
                      //           ),
                      //         ],
                      //       )),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
