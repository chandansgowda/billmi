
import 'package:flutter/material.dart';

import '../../../providers/product.dart';
import '../../../widgets/order_quantity_popup.dart';

class ProductsBottomBar extends StatelessWidget {
  const ProductsBottomBar({
    Key? key,
    required TextEditingController snController,
    required this.products,
  }) : _snController = snController, super(key: key);

  final TextEditingController _snController;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: ListTile(
            minVerticalPadding: 10,
            leading:
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (_){
                return AlertDialog(
                  content: Container(
                      width: MediaQuery.of(context)
                          .size
                          .width /
                          3.5,
                      height: MediaQuery.of(context)
                          .size
                          .width /
                          10,
                      child: Center(
                        child:
                        Text("Support Not Available on Desktop", style: TextStyle(color: Colors.red, fontSize: 35),textAlign: TextAlign.center,),
                      )),
                );
              });
            }, child: Text("SCAN")),
            title: TextField(
              controller: _snController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(
                  "Or Enter Product ID",
                  style: TextStyle(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white70.withOpacity(0.2),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.deepOrange, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                contentPadding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              ),
            ),
            trailing: ElevatedButton(
                onPressed: () {
                  final Product product = products.firstWhere(
                          (prod) =>
                      prod.sn == int.parse(_snController.text),
                      orElse: () => Product(
                          available: 0,
                          imageUrl: 'null',
                          name: 'null',
                          price: 0,
                          sn: 0));
                  showDialog(
                      context: context,
                      builder: (_) {
                        return (product.available != 0)
                            ? Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width /
                                  2,
                              height: MediaQuery.of(context)
                                  .size
                                  .width /
                                  3,
                              color: Colors.transparent,
                              child: OrderQuantityCard(
                                  sn: product.sn,
                                  name: product.name,
                                  price: product.price))

                            : AlertDialog(
                          content: Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width /
                                  3.5,
                              height: MediaQuery.of(context)
                                  .size
                                  .width /
                                  10,
                              child: Center(
                                child:
                                Text("Product Not Available", style: TextStyle(color: Colors.red, fontSize: 35),),
                              )),
                        );
                      });
                  _snController.clear();
                },
                child: Text("Add To Cart")),
            tileColor: Colors.deepOrange,
          )),
    );
  }
}
