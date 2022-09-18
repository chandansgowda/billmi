import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:billmi/utils/rupee_extension.dart';

import '../utils/secret.dart';
import 'order.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<Order> orderList = [];

  List<Order> get order {
    return [...orderList];
  }

  Future<void> fetchAndSetOrders(String userId) async {
    final url = Uri.parse(
        "$firebaseApiUrl/$userId/orders.json");
    final response = await http.get(url);
    final List<Order> loadedOrders = [];
    final extractedData = json.decode(response.body);
    extractedData.forEach((id,ordData) {
      loadedOrders.insert(0,Order.fromJson(ordData));
      orderList = loadedOrders;
      notifyListeners();
    });
  }

  Future<void> addOrder(Order newOrder, String userId) { //NOTE: call this with listen=false or else it will add infinte products
    final url = Uri.parse(
        "$firebaseApiUrl/$userId/orders.json");
    return http
        .post(
      url, 
      body: json.encode(newOrder.toJson()),
    )
        .then((response) async {
         await http.post(Uri.parse("https://api.sendinblue.com/v3/smtp/email/"),headers: <String, String>{
            'Content-Type': 'application/json' , 'accept': 'application/json', 'api-key': '$sendInBlueApiKey'
          }, body: json.encode({
            "sender":{
              "name":"BillMi",
              "email":"no-reply@mi.com"
            },
            "to":[
              {
                "email":"${newOrder.cEmail.trim()}",
                "name":"${newOrder.cName}"
              }
            ],
            "subject":"BillMi Order Confirmation",
            "htmlContent":"<html><head></head><body><h1>BillMi Thanks You For the Order</h1><h3>Product IDs - ${newOrder.items.toString()}</h3><h3>Order Total - ${double.parse(newOrder.price).toInt().inRupeesFormat()}</h3><h3>Payment Status - ${(newOrder.paymentStatus) ? "Verified" : "Pending"}</h3></body></html>",
            "headers":{
              "charset":"iso-8859-1"
            }
          }));
      fetchAndSetOrders(userId);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  static Future<String> getRazorpayOrderId(int price) async{
    final url = Uri.parse(
        "https://api.razorpay.com/v1/orders");
    final response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json' ,"Authorization":
      "Basic ${base64Encode(utf8.encode('$razorpayKeyId:$razorpayKeySecret'))} " }, body: json.encode({
      "amount": price*100,
      "currency": "INR",
      "receipt": "${DateTime.now()}"
    }));

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return json.decode(response.body)["id"];
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return "null";
    }
  }

}
