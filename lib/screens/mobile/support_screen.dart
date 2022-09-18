import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:billmi/providers/user.dart';
import 'package:provider/provider.dart';

class SupportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Technical Support"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, top: 25, bottom: 40, right: 25),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Tawk(
            directChatLink: 'https://tawk.to/chat/6325ee1154f06e12d8954a5d/1gd62jtde',
            visitor: TawkVisitor(
              name: user.storeName,
              email: "${user.id}@mi.com",
            ),
          ),
        ),
      ),
    );
  }
}