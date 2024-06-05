import 'package:my_app/models/cart_product.dart';
import 'package:my_app/models/product.dart';
import "package:flutter/material.dart";
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Util {
  static int getTotalInCart(List<CartProductModel> products) {
    int sum = 0;
    products.forEach((product) {
      sum = sum + (product.price * product.quantity);
    });

    return sum;
  }

  static int getRatingForProduct(Product product) {
    int sum = 0;
    product.comments?.forEach((product) {
      sum = sum + product.rating;
    });
    if (product.comments!.isEmpty) {
      return 1;
    }
    return (sum / product.comments!.length).floor();
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

  static CartProductModel createCartModel(Product product, int quantity) {
    CartProductModel cartProduct = CartProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        type: product.type,
        author: product.author,
        inCart: product.inCart,
        isLiked: product.isLiked,
        details: product.details,
        rating: product.rating,
        quantity: quantity);
    return cartProduct;
  }

  static makeActionDependIfUserLogedIn(BuildContext ctx, Function onDone) {
    bool isUserLogedIn =
        Provider.of<UserProvider>(ctx, listen: false).user != null;
    if (isUserLogedIn) {
      onDone();
    } else {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: ((context) => const LoginPage()),
        ),
      );
    }
  }
}
