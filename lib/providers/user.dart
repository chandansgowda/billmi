import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../utils/secret.dart';

class UserProvider extends ChangeNotifier{
  String id, storeName, storeType, token;

  UserProvider({
    this.id ="",
    this.storeName = "",
    this.storeType = "",
    this.token = "",
});

  Future<void> fetchAndSetUser() async {
    final user = FirebaseAuth.instance.currentUser;
    late final userEmail = user?.email;
    late final userId = userEmail?.substring(0,userEmail.indexOf("@"));
    final url = Uri.parse(
        "$firebaseApiUrl/$userId/storeDetails.json");
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    token = (await user?.getIdToken())!;
    id = userId!;
    storeName = extractedData["name"];
    storeType = extractedData["type"];

  }

}