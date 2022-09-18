import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:billmi/screens/login_screen.dart';
import 'package:billmi/providers/cart.dart';
import 'package:billmi/providers/orders.dart';
import 'package:billmi/providers/products.dart';
import 'package:billmi/providers/user.dart';
import 'package:billmi/screens/mobile/customer_details_input_screen.dart';
import 'package:billmi/screens/mobile/m_home_screen.dart';
import 'package:billmi/screens/mobile/inventory_screen.dart';
import 'package:billmi/screens/mobile/m_login_screen.dart';
import 'package:billmi/screens/mobile/previous_order_detail_screen.dart';
import 'package:billmi/screens/mobile/previous_orders_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screens/mobile/cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Orders()),
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(
        title: "BillMi",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
        home: LoginScreen(),
        routes: {
          MLoginScreen.routeName: (ctx) => MLoginScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          MHomeScreen.routeName: (ctx) => MHomeScreen(),
          CustomerDetailsInputScreen.routeName: (ctx) =>
              CustomerDetailsInputScreen(),
          InventoryScreen.routeName: (ctx) => InventoryScreen(),
          PreviousOrdersScreen.routeName:(ctx)=>PreviousOrdersScreen(),
          PreviousOrderDetailsScreen.routeName:(ctx)=>PreviousOrderDetailsScreen(),
          CartScreen.routeName:(ctx)=>CartScreen(),
        },
      ),
    );
  }
}
