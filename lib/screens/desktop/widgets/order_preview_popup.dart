import 'package:flutter/material.dart';
import 'package:billmi/providers/user.dart';
import 'package:billmi/utils/rupee_extension.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart.dart';
import '../../../providers/order.dart';
import '../../../providers/orders.dart';
import '../../../widgets/order_details_preview.dart';

class OrderPreviewPopup extends StatefulWidget {
  const OrderPreviewPopup({
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
  State<OrderPreviewPopup> createState() => _OrderPreviewPopupState();
}

class _OrderPreviewPopupState extends State<OrderPreviewPopup> {
  TextEditingController _cashController = TextEditingController();
  bool isCreatingOrder = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Order Preview",
        style: TextStyle(
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: MediaQuery.of(context)
            .size
            .height /
            1.5,
        width: MediaQuery.of(context)
            .size
            .width /
            3,
        child: Stack(
          children: [Column(
            children: [
              OrderDetailsPreview(nameController: widget._nameController, emailController: widget._emailController, mobileController: widget._mobileController, addressController: widget._addressController, cartItems: widget.cartItems, totalCartValue: widget.totalCartValue),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: _cashController,
                  keyboardType: TextInputType.number,
                  onChanged: (_){
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      label: Text(
                        "Cash Received",
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                      helperText: "Desktop Mode Only Supports Cash Payments",
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
                      suffix: ((_cashController.text.toString() == ((widget.totalCartValue * 1.18).truncate()).toString())) ? Icon(Icons.verified, color: Colors.green,) : null
                  ),
                ),
              ),
            ],
          ),
            if (isCreatingOrder)
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white70.withOpacity(0.35),
                  child: Center(child: CircularProgressIndicator(color: Colors.deepOrange,),),
                ),
              )
          ]
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Go Back")),
        ElevatedButton(
            onPressed: () async {

              final List<int> orderItems =
              [];
              widget.cartItems.forEach((item) {
                for (int i = 0;
                i < item.quantity;
                i++) {
                  orderItems.add(item.sn);
                }
              });
              final cName = widget._nameController.text;
              final cEmail = widget._emailController.text;
              final cPhone = widget._mobileController.text;
              final cAddress = widget._addressController.text;
              final totalPrice = (widget.totalCartValue*1.18).toString();
              final date = DateTime.now().toString();
              if (orderItems.length > 0 && cName!="" && cPhone!="" && cEmail!= "" && _cashController.text==(widget.totalCartValue * 1.18).truncate().toString()) {
                setState(() {
                  isCreatingOrder = true;
                });
                final newOrder = Order(
                    cEmail: cEmail,
                    cName: cName,
                    cPhone: int.parse(cPhone),
                    items: orderItems,
                    paymentMode: "Cash",
                    paymentStatus: true,
                    price: totalPrice, date: date, cAddress: cAddress, deliveryType: 'Store Pickup');
                await Provider.of<Orders>(context,
                    listen: false)
                    .addOrder(newOrder, Provider.of<UserProvider>(context,listen: false).id);
                setState(() {
                  isCreatingOrder = false;
                });
                showDialog(context: context, builder: (_){
                  return AlertDialog(
                    actions: [
                      ElevatedButton(onPressed: (){
                        //TODO: Print Invoice
                      }, child: Text("Print Invoice")),
                      ElevatedButton(onPressed: (){
                        widget._nameController.clear();
                        widget._emailController.clear();
                        widget._mobileController.clear();
                        widget._addressController.clear();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Provider.of<Cart>(context, listen:false).clear();
                      }, child: Text("New Order")),

                    ],
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
                          Column(
                            children: [
                              Icon(Icons.verified, color: Colors.green,size: 60,),
                              Text("Order Successfull", style: TextStyle(color: Colors.green, fontSize: 35),),
                            ],
                          ),
                        )),
                  );
                });
              }
              else{
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
                          Text("Some Error Occured. Check all fields and Try again!", textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontSize: 20),),
                        )),
                  );
                });

              }
            },
            child: Text("Confirm Order")),
      ],
    );
  }
}

