import 'package:flutter/material.dart';

import '../../../providers/product.dart';
import '../../../widgets/inventory_card_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.8,
          child: GridView(
            controller: ScrollController(),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (1 / .315),
                crossAxisSpacing: 20,
                mainAxisSpacing: 10),
            children: products.map((product) {
              return InventoryCardItem(
                  name: product.name,
                  sn: product.sn,
                  price: product.price,
                  available: product.available,
                  imageUrl: product.imageUrl,
                  isClickable: true,);
            }).toList(),
          ),
        ),
      ),
    );
  }
}