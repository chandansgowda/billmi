class Product {
  late int available;
  late String imageUrl;
  late String name;
  late int price;
  late int sn;

  Product({required this.available, required this.imageUrl, required this.name, required this.price, required this.sn});

  Product.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    price = json['price'];
    sn = json['sn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['price'] = this.price;
    data['sn'] = this.sn;
    return data;
  }
}
