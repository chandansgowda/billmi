class Order {
  late String cEmail;
  late String cName;
  late String cAddress;
  late int cPhone;
  late List<int> items;
  late String paymentMode;
  late bool paymentStatus;
  late String price;
  late String date;
  late String deliveryType;

  Order(
      {required this.cEmail,
        required this.cName,
        required this.cPhone,
        required this.cAddress,
        required this.items,
        required this.paymentMode,
        required this.paymentStatus,
        required this.price,
        required this.deliveryType,
        required this.date,});

  Order.fromJson(Map<String, dynamic> json) {
    cEmail = json['cEmail'];
    cName = json['cName'];
    cPhone = json['cPhone'];
    cAddress = json['cAddress'];
    items = json['items'].cast<int>();
    paymentMode = json['paymentMode'];
    paymentStatus = json['paymentStatus'];
    price = json['price'];
    date = json['date'];
    deliveryType = json['deliveryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cEmail'] = this.cEmail;
    data['cName'] = this.cName;
    data['cPhone'] = this.cPhone;
    data['cAddress'] = this.cAddress;
    data['items'] = this.items;
    data['paymentMode'] = this.paymentMode;
    data['paymentStatus'] = this.paymentStatus;
    data['price'] = this.price;
    data['date'] = this.date;
    data['deliveryType'] = this.deliveryType;
    return data;
  }
}
