import 'package:my_app/models/cart_product.dart';
import 'package:my_app/models/product.dart';

class SingleProductArguments {
  Product product;
  List<CartProductModel> cart;
  Function(Product) onAddToCartClick;
  SingleProductArguments(
      {required this.product,
      required this.cart,
      required this.onAddToCartClick});
}
