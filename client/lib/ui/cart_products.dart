import 'package:flutter/cupertino.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/ui/cart_product.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key});
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProductProvider>(context, listen: true);
    return Column(
      children: data.cart
          .map(
            (product) => Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: CartProduct(
                product: product,
              ),
            ),
          )
          .toList(),
    );
  }
}
