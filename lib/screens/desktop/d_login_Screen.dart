import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:billmi/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/user.dart';

class DLoginScreen extends StatefulWidget {
  @override
  State<DLoginScreen> createState() => _DLoginScreenState();
}

class _DLoginScreenState extends State<DLoginScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isLoggingIn = false;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "assets/bg.png",
          fit: BoxFit.cover,
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.75),
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 80, color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      label: Text(
                        "Mi ID / Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white70.withOpacity(0.2),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(
                        "Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white70.withOpacity(0.2),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      var id = _idController.text;
                      final pass = _passwordController.text;
                      if (id.length>4 && !id.contains("@")){
                        id = "$id@mi.com";
                      }
                      try {
                        setState(() {
                          isLoggingIn = true;
                        });
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: id, password: pass);
                        if (FirebaseAuth.instance.currentUser!=null){
                          await Provider.of<UserProvider>(context, listen:false).fetchAndSetUser();
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                        }
                      }
                      catch(e){
                        setState(() {
                          isLoggingIn = false;
                        });
                        showDialog(context: context, builder: (_) {
                          return AlertDialog(
                            title: Text("Some Error Occured. Try Again!"),
                            content: Text("Error Log\n$e"),
                          );
                        });
                      }},
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(200, 50)),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.deepOrange.withOpacity(0.1))),
                  )
                ],
              ),
            ),
          ),
        ),
        if (isLoggingIn)
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white70.withOpacity(0.35),
              child: Center(child: CircularProgressIndicator(color: Colors.deepOrange,),),
            ),
          )
      ]),
    );
  }
}
