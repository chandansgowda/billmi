import 'package:flutter/material.dart';
import 'package:billmi/utils/colors.dart';
import 'package:billmi/utils/rupee_extension.dart';
import 'package:billmi/utils/secret.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../providers/cart.dart';
import '../../providers/order.dart';
import '../../providers/orders.dart';
import '../../providers/user.dart';

class PreviewOrderScreen extends StatefulWidget {
  static const routeName = '/m-preview-order-screen';
  String cName, cEmail, cAddress;
  int cPhone;

  PreviewOrderScreen({
    required this.cName,
    required this.cEmail,
    required this.cAddress,
    required this.cPhone,
  });

  @override
  State<PreviewOrderScreen> createState() => _PreviewOrderScreenState();
}

class _PreviewOrderScreenState extends State<PreviewOrderScreen> {
  String deliveryType = "Store Pickup";
  TextEditingController _cashController = TextEditingController();
  final _razorpay = Razorpay();
  bool paymentStatus = false;
  int totalPrice = 0;
  String paymentMode = "Cash";
  bool paymentConfirmationLoading = false;

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void razorpayLogin(int price) async{
    setState(() {
      paymentConfirmationLoading = true;
    });
    final orderId = await Orders.getRazorpayOrderId(price);
    totalPrice = price;
    var options = {
      'key': '$razorpayKeyId',
      'currency': 'INR',
      'amount': price*100, //multiple of 100 has to be passed
      'order_id': orderId,
      'name': '${widget.cName}',
      'description': 'BillMi Order',
      'prefill': {'contact': '${widget.cPhone}', 'email': '${widget.cEmail}'}
    };
    _razorpay.open(options);
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      paymentStatus = true;
      _cashController.text = totalPrice.toString();
      paymentMode = "Razorpay";
      paymentConfirmationLoading = false;
    });
    _razorpay.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      paymentConfirmationLoading = false;
    });
    showDialog(context: context, builder: (_){
      return AlertDialog(
        content: Text("ERROR: " + response.code.toString() + " - " + response.message.toString()),
      );
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    paymentConfirmationLoading = false;
  }


  Future<void> createAndAddOrder(List<CartItem> cartItems, int totalCartValue) async {
    final List<int> orderItems = [];
    cartItems.forEach((item) {
      for (int i = 0; i < item.quantity; i++) {
        orderItems.add(item.sn);
      }
    });
    final totalPrice = (totalCartValue * 1.18);
    final date = DateTime.now().toString();
    if (orderItems.length > 0 && (_cashController.text.toString() == ((totalCartValue * 1.18).truncate()).toString() || paymentStatus==true)) {
      setState(() {
        paymentConfirmationLoading = true;
      });
      final newOrder = Order(
          cEmail: widget.cEmail,
          cName: widget.cName,
          cPhone: widget.cPhone,
          items: orderItems,
          paymentMode: paymentMode,
          paymentStatus: true,
          price: totalPrice.toString(),
          date: date,
          cAddress: widget.cAddress,
          deliveryType: deliveryType);
      await Provider.of<Orders>(context, listen: false)
          .addOrder(
          newOrder,
          Provider.of<UserProvider>(context,
              listen: false)
              .id);
      setState(() {
        paymentConfirmationLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              actions: [
                ElevatedButton(
                    onPressed: () {
                      paymentStatus=false;
                      Provider.of<Cart>(context,
                          listen: false)
                          .clear();
                      for (int i = 0; i < 4; i++) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Dashboard"))
              ],
              content: Container(
                  height:
                  MediaQuery.of(context).size.height /
                      4,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 60,
                        ),
                        Text(
                          "Order Successfull",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 35),
                        ),
                      ],
                    ),
                  )),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Container(
                  height:
                  MediaQuery.of(context).size.height /
                      5,
                  child: Center(
                    child: Text(
                      "Cash Received is not equal to total! Try Again.",
                      style: TextStyle(
                          color: Colors.red, fontSize: 20),
                    ),
                  )),
            );
          });
    }
  }

  @override
  void dispose() {
    try {
      _razorpay.clear();
    }finally {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context).items;
    final totalCartValue = Provider.of<Cart>(context).totalAmount.toInt();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColour,
          title: Text(
            "Order Preview",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Column(
                      children: [
                        Text(
                          "Customer Details",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
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
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "${widget.cName}",
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Text(
                                  "Email",
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "${widget.cEmail}",
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Text(
                                  "Mobile",
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "${widget.cPhone}",
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Text(
                                  "Address",
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "${widget.cAddress}",
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Products in Cart",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
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
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "Price",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "Qty",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                )),
                              ]),
                              ...cartItems.map((item) {
                                return TableRow(children: [
                                  TableCell(
                                      child: Text(
                                    "${item.name}",
                                    textAlign: TextAlign.center,
                                  )),
                                  TableCell(
                                      child: Text(
                                    "Rs. ${item.price}",
                                    textAlign: TextAlign.center,
                                  )),
                                  TableCell(
                                      child: Text(
                                    "${item.quantity}",
                                    textAlign: TextAlign.center,
                                  )),
                                ]);
                              }).toList(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Order Value",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(children: [
                                TableCell(
                                    child: Text(
                                  "Subtotal",
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "Rs $totalCartValue",
                                  textAlign: TextAlign.center,
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Text(
                                  "Tax (18%)",
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "Rs ${(totalCartValue * (0.18)).truncate()}",
                                  textAlign: TextAlign.center,
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Text(
                                  "Total Due",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                )),
                                TableCell(
                                    child: Text(
                                  "${((totalCartValue * 1.18).truncate()).inRupeesFormat()}",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                )),
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Divider(),
                        Text(
                          "Delivery Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 11,
                        ),
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
                        Divider()
                      ],
                    ),
                  ),
                ),
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
                      helperText: "Manually enter for cash payments only.",
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
                      suffix: ((_cashController.text.toString() == ((totalCartValue * 1.18).truncate()).toString() || paymentStatus)) ? Icon(Icons.verified, color: Colors.green,) : null
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            razorpayLogin((totalCartValue * 1.18).toInt());
                          },
                          child: Row(
                            children: [
                              if (paymentStatus)
                                Icon(Icons.verified_rounded, color: Colors.green,),
                              Text("UPI/Credit/Debit",),
                            ],
                          )),
                      ElevatedButton(
                        onPressed: () async {
                          await createAndAddOrder(cartItems, totalCartValue);
    },
                        child: Text("Confirm Payment"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (paymentConfirmationLoading)
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white70.withOpacity(0.35),
                child: Center(child: CircularProgressIndicator(color: Colors.deepOrange,),),
              ),
            )
          ]
        ));
  }
}
