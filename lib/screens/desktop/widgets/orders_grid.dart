import 'package:flutter/material.dart';
import 'package:billmi/providers/order.dart';
import 'package:billmi/widgets/previous_order_tile.dart';

class OrdersGrid extends StatelessWidget {
  const OrdersGrid({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.8,
          child: GridView(
            controller: ScrollController(),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (1 / .315),
                crossAxisSpacing: 20,
                mainAxisSpacing: 10),
            children: orders.map((order) {
              return PreviousOrderTile(previousOrderItem: order);
            }).toList(),
          ),
        ),
      ),
    );
  }
}