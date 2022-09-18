import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:billmi/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../providers/user.dart';
import '../home_screen.dart';

class MLoginScreen extends StatefulWidget {
  static const routeName = '/m-login-screen';
  @override
  State<MLoginScreen> createState() => _MLoginScreenState();
}

class _MLoginScreenState extends State<MLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var userid;
  var password;
  bool isLoggingIn = false;

  void loginUser() async {
    setState(() {
      isLoggingIn = true;
    });
    var id = emailController.text;
    final pass = passwordController.text;
    if (id.length > 4 && !id.contains("@")) {
      id = "$id@mi.com";
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: id, password: pass);
      if (FirebaseAuth.instance.currentUser != null) {
        await Provider.of<UserProvider>(context, listen: false)
            .fetchAndSetUser();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
        // Navigator.of(context).pop();
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("Some Error Occured. Try Again!"),
              content: Text("Error Log\n$e"),
            );
          });
    }
    finally{
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [ Padding(
          padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  width: 150,
                  child: null,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage("assets/icon.png"))),
                ),
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: kPrimaryColour,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 35.0, horizontal: 20.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 3.0)),
                                    labelText: 'MI ID',
                                    hintText: 'Enter you MI ID'),
                                validator: (value) {
                                  if (value == Null) {
                                    return "* Required";
                                  } else
                                    userid = value;
                                },
                              ),
                              SizedBox(
                                height: 45,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3.0)),
                                  labelText: 'Password',
                                  hintText: 'Enter password',
                                ),
                                validator: (value) {
                                  if (value == Null) {
                                    return "* Required";
                                  } else
                                    password = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.5),
                      InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          loginUser();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            color: kPrimaryColour,
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 23.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
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
        ]
      ),
    );
  }
}
