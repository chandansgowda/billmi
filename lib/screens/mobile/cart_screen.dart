import 'package:flutter/material.dart';
import 'package:billmi/providers/cart.dart';
import 'package:billmi/screens/desktop/widgets/cart_item_card.dart';
import 'package:billmi/utils/colors.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName="/m-cart-screen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItems=Provider.of<Cart>(context).items;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColour,
        title: Text("Cart Items",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: cartItems.length>0?ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context,index)=>CartItemCard(cartItems: cartItems, item: cartItems[index])):Center(child: Text("No Cart Items"),),
      )
    );
  }
}
