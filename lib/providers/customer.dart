class Customer {
  late String address;
  late String email;
  late String name;
  late int phone;

  Customer(
      {required this.address,
      required this.email,
      required this.name,
      required this.phone});

  Customer.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
