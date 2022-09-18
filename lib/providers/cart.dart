import 'package:flutter/material.dart';

class CartItem{
  int sn;
  String name;
  int price;
  int quantity;

  CartItem({
    required this.sn,
    required this.name,
    required this.price,
    required this.quantity
  });

  CartItem incrementQuantity(){
    quantity++;
    return this;
  }
}

class Cart with ChangeNotifier{
  List<CartItem> _items = [];

  List<CartItem> get items{
    return [..._items];
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((cartItem){
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get itemCount{
    return _items==null ? 0 : _items.length;
  }

  void addItem(CartItem newItem){
    _items.add(newItem);
    notifyListeners();
  }


  void removeCartItem(int sn){
    _items.removeWhere((item) => item.sn==sn);
    notifyListeners();
  }

  void clear(){
    _items = [];
    notifyListeners();
  }

}