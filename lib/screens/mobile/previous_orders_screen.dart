import 'package:flutter/material.dart';
import 'package:billmi/providers/orders.dart';
import 'package:billmi/widgets/previous_order_tile.dart';
import 'package:billmi/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../providers/order.dart';

class PreviousOrdersScreen extends StatefulWidget {
  static const routeName='/m-previous-orders-screen';
  @override
  State<PreviousOrdersScreen> createState() => _PreviousOrdersScreenState();
}

class _PreviousOrdersScreenState extends State<PreviousOrdersScreen> {
  List<Order> previousOrders=[];
  void getPreviousOrders() {
    previousOrders= Provider.of<Orders>(context,listen: false).order;
  }
  @override
  void didChangeDependencies(){
    getPreviousOrders();
    setState(() {
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Orders",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor:kPrimaryColour,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: previousOrders.length,
            itemBuilder: (context,index)=>PreviousOrderTile(previousOrderItem: previousOrders[index])),
      ),
    );
  }
}


