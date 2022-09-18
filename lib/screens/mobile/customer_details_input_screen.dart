import 'package:flutter/material.dart';
import 'package:billmi/screens/mobile/order_screen.dart';
import 'package:billmi/utils/colors.dart';

class CustomerDetailsInputScreen extends StatefulWidget {
  const CustomerDetailsInputScreen({Key? key}) : super(key: key);
  static const routeName='/m-customer-details-input-screen';
  @override
  State<CustomerDetailsInputScreen> createState() =>
      _CustomerDetailsInputScreenState();
}

class _CustomerDetailsInputScreenState
    extends State<CustomerDetailsInputScreen> {
  var _index = 0;
  String mail = "";
  String name = "";
  int mNumber = 0;
  String address = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColour,
        elevation: 0,
        title: Text("Customer Details",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stepper(
                currentStep: _index,
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  if (_index < 3) {
                    setState(() {
                      _index += 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                steps: [
                  Step(
                    title: StepName(label:"Full Name*",value: name,validator: null,),
                    content: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Eg: Chandan Gowda",
                      ),
                    ),
                  ),
                  Step(
                    title: StepName(label: "Email*",value:mail,validator: ""),
                    content: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          mail = value;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Order confirmation mail will be sent",
                      ),
                    ),
                  ),
                  Step(
                    title: StepName(label: "Mobile Number*",value: mNumber,validator: 0,),
                    content: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          mNumber = int.parse(value);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Whatsapp No. (recommended)",
                      ),
                    ),
                  ),
                  Step(
                    title: StepName(label: "Address*",value: address,validator: "",),
                    content: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your address",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  if (name!=""&&mail!=""&&mNumber!=""&&address!="")
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> OrderScreen(cName: name, cPhone: mNumber, cEmail: mail, cAddress: address)));
                  else
                    showDialog(context: context, builder: (_){
                      return AlertDialog(
                        title: Text("Required fields empty!", textAlign: TextAlign.center,),
                      );
                    });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFFF6900),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Text(
                      "Add Products",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepName extends StatelessWidget {
  StepName({
    required this.label,
    required this.validator,
    required this.value,

  });
  final String label;
  final dynamic value;
  final dynamic validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label),
        if (value != validator)
          Text(
            value.toString(),
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
      ],
    );
  }
}
