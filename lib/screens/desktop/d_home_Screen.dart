
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:billmi/providers/cart.dart';
import 'package:billmi/screens/desktop/widgets/cart_item_card.dart';
import 'package:billmi/screens/desktop/widgets/orders_grid.dart';
import 'package:billmi/screens/desktop/widgets/products_grid.dart';
import 'package:billmi/utils/rupee_extension.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../providers/order.dart';
import '../../providers/orders.dart';
import '../../providers/product.dart';
import '../../providers/products.dart';
import '../../providers/user.dart';
import 'widgets/customer_details_form.dart';
import 'widgets/main_app_bar.dart';
import 'widgets/order_preview_popup.dart';
import 'widgets/products_grid_bottom_bar.dart';

class DHomeScreen extends StatefulWidget {
  @override
  State<DHomeScreen> createState() => _DHomeScreenState();
}

class _DHomeScreenState extends State<DHomeScreen> {
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  late List<Product> products = [];
  late List<Order> orders = [];
  late String storeName = "";
  late String storeType = "";
  bool dataLoaded = false;
  bool showProducts = true;
  bool showOrders = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _snController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  void getStoreDetailsAndProducts() async {
    await Provider.of<Products>(context, listen:false).fetchAndSetProducts(Provider.of<UserProvider>(context, listen: false).id);
    await Provider.of<Orders>(context, listen:false).fetchAndSetOrders(Provider.of<UserProvider>(context, listen: false).id);
    products = await Provider.of<Products>(context, listen: false).items;
    orders = Provider.of<Orders>(context, listen: false).order;
    storeName = Provider.of<UserProvider>(context, listen: false).storeName;
    storeType = Provider.of<UserProvider>(context, listen: false).storeType;
    setState(() {
      dataLoaded = true;
    });
  }

  @override
  void didChangeDependencies() {
    getStoreDetailsAndProducts();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _snController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context).items;
    final totalCartValue = Provider.of<Cart>(context).totalAmount.toInt();
    return Scaffold(
      appBar: MainAppBar(auth: _auth, storeType: storeType, storeName:  storeName,),
            body: Row(
        children: [
          Container(
            height: double.infinity,
            width: 10,
            color: Colors.deepOrange,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white38,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.deepOrange,
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              "CUSTOMER",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        CutomerDetailsForm(addressController: _addressController, nameController: _nameController, emailController: _emailController, mobileController: _mobileController),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white38,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.deepOrange,
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              "CART ITEMS",
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: MediaQuery.of(context).size.height / 2.6,
                            child: ListView(
                              children: cartItems.map((item) {
                                return CartItemCard(
                                  cartItems: cartItems,
                                  item: item,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          child: Card(
                              child: ListTile(
                            minVerticalPadding: 15,
                            title: Text(
                              "${totalCartValue.inRupeesFormat()}/-",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                            trailing: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return OrderPreviewPopup(nameController: _nameController, emailController: _emailController, mobileController: _mobileController, cartItems: cartItems, totalCartValue: totalCartValue, addressController: _addressController,);
                                      });
                                },
                                child: const Text("Place Order")),
                            tileColor: Colors.deepOrange,
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: double.infinity,
            width: 10,
            color: Colors.deepOrange,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.deepOrange,
                  width: double.infinity,
                  child: Center(
                    child: ToggleSwitch(
                      minWidth: 150,
                      initialLabelIndex: (showProducts) ? 0 : 1,
                      cornerRadius: 0,
                      activeFgColor: Colors.black,
                      inactiveBgColor: Colors.deepOrange,
                      inactiveFgColor: Colors.black,
                      totalSwitches: 2,
                      labels: ['Products', 'Orders History'],
                      icons: [Icons.store, Icons.history],
                      activeBgColors: [
                        [Colors.white],
                        [Colors.white]
                      ],
                      onToggle: (index) {
                       setState(() {
                         if (index==0) {
                           showProducts=true;
                           showOrders = false;
                         }
                         if (index==1){
                           showProducts=false;
                           showOrders = true;
                         }

                       });
                      },
                    ),
                  ),
                ),
                if (dataLoaded && showProducts)
                  ProductsGrid(products: products),
                if (dataLoaded && showOrders)
                  OrdersGrid(orders: orders),
                if (!dataLoaded)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  ),
                ProductsBottomBar(snController: _snController, products: products)
              ],
            ),
          ),
          Container(
            height: double.infinity,
            width: 10,
            color: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}







