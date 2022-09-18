import 'package:flutter/material.dart';
import 'package:billmi/providers/product.dart';
import 'package:billmi/providers/products.dart';
import 'package:billmi/widgets/inventory_card_item.dart';
import 'package:billmi/utils/colors.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  static const routeName='/m-inventory-screen';
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {

  int _selectedIndex=0;
  bool dataLoaded=false;
  late List<Product> products;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void getProducts() async{
    products = await Provider.of<Products>(context).items;
    setState((){
      dataLoaded=true;
    });
  }
  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
  }

  late List _bodyItems=[
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context,index)=>InventoryCardItem(name: products[index].name, sn: products[index].sn, price: products[index].price, available: products[index].available, imageUrl: products[index].imageUrl, isClickable: false,))
    ),
    // Center(child: Text("Laptops"),),
    // Center(child: Text("TV"),),
    // Center(child: Text("Watches"),),
    // Center(child: Text("Accessories"),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColour,
        title: Text("Inventory",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: dataLoaded?_bodyItems.elementAt(_selectedIndex):const Center(
        child: CircularProgressIndicator(color: Colors.deepOrange,),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white54,
      //   selectedLabelStyle: TextStyle(height: 1.5),
      //   onTap: _onItemTapped,
      //   items: [
      //     BottomNavigationBarItem(backgroundColor: kPrimaryColour,icon: Icon(Icons.phone_android),label: "Mobiles"),
      //     BottomNavigationBarItem(icon: Icon(Icons.laptop),label: "Laptops"),
      //     BottomNavigationBarItem(icon: Icon(Icons.tv),label: "TV's"),
      //     BottomNavigationBarItem(icon: Icon(Icons.watch_outlined),label: "Watches"),
      //     BottomNavigationBarItem(icon: Icon(Icons.format_quote),label: "Accessories"),
      //   ],
      // ),
    );
  }
}


