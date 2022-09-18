import 'package:flutter/material.dart';
import 'package:billmi/utils/colors.dart';
import 'package:billmi/utils/rupee_extension.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    required this.cartItems,
    required this.item,
  });

  final CartItem item;
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            "${cartItems.indexOf(item)+1}",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor:
          kPrimaryColour.withOpacity(0.5),
          radius: 16,
        ),
        title: Text("${item.name}"),
        trailing: Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${item.price.inRupeesFormat()}    x ${item.quantity}"),
              IconButton(onPressed: (){
                Provider.of<Cart>(context, listen: false).removeCartItem(item.sn);
              }, icon: Icon(Icons.delete, color: Colors.red),splashRadius: 20,)
            ],
          ),
        ),
      ),
    );
  }
}