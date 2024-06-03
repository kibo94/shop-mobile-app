import 'package:my_app/models/product.dart';
import "package:flutter/material.dart";

class Util {
  static int getTotalInCart(List<Product> products) {
    int sum = 0;
    products.forEach((product) {
      sum = sum + (product.price * product.quantity);
    });

    return sum;
  }

  static SnackBar snackBar(String msg, BuildContext ctx) {
    return SnackBar(
      backgroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 23),
      duration: const Duration(seconds: 1),
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: Theme.of(ctx).textTheme.headline3?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
