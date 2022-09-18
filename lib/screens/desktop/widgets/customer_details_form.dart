import 'package:flutter/material.dart';

class CutomerDetailsForm extends StatelessWidget {
  const CutomerDetailsForm({
    Key? key,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController mobileController,
    required TextEditingController addressController,
  }) : _nameController = nameController, _emailController = emailController, _mobileController = mobileController, _addressController = addressController, super(key: key);

  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _mobileController;
  final TextEditingController _addressController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: Text(
                    "Name",
                    style:
                    TextStyle(color: Colors.deepOrange),
                  ),
                  filled: true,
                  fillColor: Colors.white70.withOpacity(0.2),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrange),
                      borderRadius:
                      BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrange, width: 2),
                      borderRadius:
                      BorderRadius.circular(20)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  label: Text(
                    "Email",
                    style:
                    TextStyle(color: Colors.deepOrange),
                  ),
                  filled: true,
                  fillColor: Colors.white70.withOpacity(0.2),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrange),
                      borderRadius:
                      BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrange, width: 2),
                      borderRadius:
                      BorderRadius.circular(20)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  label: Text(
                    "Mobile No.",
                    style:
                    TextStyle(color: Colors.deepOrange),
                  ),
                  filled: true,
                  fillColor: Colors.white70.withOpacity(0.2),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrange),
                      borderRadius:
                      BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrange, width: 2),
                      borderRadius:
                      BorderRadius.circular(20)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  label: Text(
                    "Address",
                    style:
                    TextStyle(color: Colors.deepOrange),
                  ),
                  filled: true,
                  fillColor: Colors.white70.withOpacity(0.2),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrange),
                      borderRadius:
                      BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepOrange, width: 2),
                      borderRadius:
                      BorderRadius.circular(20)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10),
                ),
              ),
            ],
          ),
        ));
  }
}