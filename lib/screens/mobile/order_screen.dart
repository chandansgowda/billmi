import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:billmi/providers/product.dart';
import 'package:billmi/screens/mobile/cart_screen.dart';
import 'package:billmi/screens/mobile/preview_order_screen.dart';
import 'package:billmi/utils/colors.dart';
import 'package:billmi/widgets/order_quantity_popup.dart';
import 'package:provider/provider.dart';

import '../../providers/cart.dart';
import '../../providers/products.dart';
import '../../widgets/cart_badge.dart';
import '../../widgets/inventory_card_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/m-order-screen';

  String cName, cEmail, cAddress;
  int cPhone;

  OrderScreen({
    required this.cName,
    required this.cPhone,
    required this.cEmail,
    required this.cAddress,
});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController _snController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Product> products = Provider.of<Products>(context).items;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColour,
        centerTitle: true,
        title: Text(
          "Add Products",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          CartBadge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              value: Provider.of<Cart>(context).itemCount.toString()),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (Provider.of<Cart>(context,listen: false).itemCount>0)
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_)=> PreviewOrderScreen(cName: widget.cName, cEmail: widget.cEmail, cAddress: widget.cAddress, cPhone: widget.cPhone)));
        },
        child: Text(
          "Preview Order",
          style: TextStyle(fontSize: 15,color: Colors.deepOrange),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  IconButton(
                      onPressed: () async {
                        _snController.text =
                        await FlutterBarcodeScanner.scanBarcode(
                            "#ff6666", "Cancel", false, ScanMode.DEFAULT);
                      },
                      icon: Icon(Icons.qr_code_scanner)),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextFormField(
                        controller: _snController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 3.0)),
                          labelText: 'Product ID',
                          hintText: 'Enter Product ID',
                        ),
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 50,
                      width: 50,
                      child: IconButton(
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
                                  return (product.available > 0)
                                      ? OrderQuantityCard(
                                          sn: product.sn,
                                          name: product.name,
                                          price: product.price)
                                      : AlertDialog(
                                          content: Container(
                                            height: MediaQuery.of(context).size.height/5,
                                              child: Center(
                                            child: Text(
                                              "Product Not Available",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 35),
                                            ),
                                          )),
                                        );
                                });
                            _snController.clear();
                          },
                          icon: Icon(
                            Icons.search,
                            size: 30,
                          )))
                ],
              ),
              Container(
                color: Colors.transparent,
                width: double.infinity,
                height: 500,
                child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) => InventoryCardItem(
                              name: products[index].name,
                              sn: products[index].sn,
                              price: products[index].price,
                              available: products[index].available,
                              imageUrl: products[index].imageUrl,
                              isClickable: true,
                            ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
