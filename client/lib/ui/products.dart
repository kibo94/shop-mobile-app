import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/data_provider.dart';
import 'package:my_app/ui/product_Item.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  const Products({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DataProvider>(context, listen: false);
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.2),
            crossAxisCount: 2, // Two cards per row
            crossAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            cart: data.cart,
            onFavoriteClick: (Product prod) => () => {},
            onAddToCartClick: (Product prod) =>
                data.onAddToCartClickHanlder(prod),
            product: products[index],
          );
        },
      ),
    ));
  }
}
