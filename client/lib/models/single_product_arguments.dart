import 'package:my_app/models/product.dart';

class SingleProductArguments {
  Product product;
  List<Product> cart;
  Function(Product) onAddToCartClick;
  SingleProductArguments(
      {required this.product,
      required this.cart,
      required this.onAddToCartClick});
}
