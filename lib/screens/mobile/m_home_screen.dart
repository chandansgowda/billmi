import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/orders.dart';
import '../../providers/products.dart';
import '../../providers/user.dart';
import '../../services/firebase_auth_services.dart';
import '../../utils/colors.dart';
import 'customer_details_input_screen.dart';
import 'inventory_screen.dart';
import 'previous_orders_screen.dart';
import 'support_screen.dart';
import 'widgets/home_screen_card.dart';

class MHomeScreen extends StatefulWidget {
  static const routeName = '/m-home-screen';


  @override
  State<MHomeScreen> createState() => _MHomeScreenState();
}

class _MHomeScreenState extends State<MHomeScreen> {

  late String storeName = "";
  late String storeType = "";

  void getStoreDetailsAndProducts() async {
    String userId=Provider.of<UserProvider>(context,listen: false).id;
    await Provider.of<Products>(context, listen:false).fetchAndSetProducts(userId);
    await Provider.of<Orders>(context,listen: false).fetchAndSetOrders(userId);
    setState(() {
      storeName = Provider.of<UserProvider>(context, listen: false).storeName;
      storeType = Provider.of<UserProvider>(context, listen: false).storeType;
    });
  }

  @override
  void didChangeDependencies() {
    getStoreDetailsAndProducts();
    super.didChangeDependencies();
  }

  void signOut() {
    FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          width: 150,
          height: 50,
          child: Image.asset(
            "assets/icon.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kPrimaryColour,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.255,
              child: Padding(
                padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.02,horizontal: MediaQuery.of(context).size.width*0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MediaQuery(
                      data: MediaQueryData(textScaleFactor: 1.25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "$storeName",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 22,),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.02,
                          ),
                          Text(
                            "Cat: $storeType",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.75),
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.white70,
                    ),
                    MediaQuery(
                      data: MediaQueryData(textScaleFactor: 1.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${Provider.of<UserProvider>(context, listen: false).id}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              signOut();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.exit_to_app,
                                  size: 28,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(CustomerDetailsInputScreen.routeName);
                          },
                          child: HomeScreenCard(
                            icon: Icons.add_shopping_cart_rounded,
                            text: "New Order",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(InventoryScreen.routeName);
                          },
                          child: HomeScreenCard(
                            icon: Icons.inventory_2_outlined,
                            text: "Inventory",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(PreviousOrdersScreen.routeName);
                          },
                          child: HomeScreenCard(
                            icon: Icons.history,
                            text: "History",
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=> SupportScreen()));
                          },
                          child: HomeScreenCard(
                            icon: Icons.support_agent,
                            text: "Support",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}