import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../utils/secret.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> itemList = [];
  List<Product> get items {
    return [...itemList];
  }

  Future<void> fetchAndSetProducts(String userId) async {
    final url = Uri.parse(
        "$firebaseApiUrl/$userId/products.json");
    final response = await http.get(url);
    final List<Product> loadedProducts = [];
    final extractedData = json.decode(response.body);
    extractedData.forEach((key,prodData) {
      loadedProducts.add(Product.fromJson(prodData));
      itemList = loadedProducts;
    });
  }


}
