import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/cart_product.dart';
import 'package:my_app/models/comment.dart';
import 'package:my_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  int? selectedProduct;
  int quantity = 1;
  List<CartProductModel> _cart = [];
  List<String> _filters = [];
  final List<Product> _favorites = [];
  List<Product> get products => _products;
  List<Product> get favorites => _favorites;
  List<String> get filters => _filters;
  List<CartProductModel> get cart => _cart;
  bool isLoadingProducts = false;
  var backendUrl = "https://shop-mobile-app-4.onrender.com";
  // var backendUrl = "https://192.168.0.103:4000";
  setProduct(int? product) {
    selectedProduct = product;
    notifyListeners();
  }

  resetCart() {
    _cart = [];
    notifyListeners();
  }

  fetchFilters() async {
    try {
      var data = await http.get(Uri.parse('$backendUrl/filters'));
      Iterable list = await json.decode(data.body);
      var filters = List<String>.from(
        list.map((e) => e),
      );
      _filters = filters;
      notifyListeners();
    } catch (e) {}
  }

  fetchProducts(BuildContext context) async {
    isLoadingProducts = true;

    try {
      var data = await http.get(Uri.parse('$backendUrl/products'));
      Iterable list = await json.decode(data.body);
      var products = List<Product>.from(
        list.map((e) => Product.fromJson(e)),
      );
      _products = products;
      isLoadingProducts = false;
      notifyListeners();
    } on SocketException catch (platformError) {
      if (platformError.message ==
          "Failed host lookup: 'shop-mobile-app-4.onrender.com'") {
        isLoadingProducts = false;
        notifyListeners();
      }
    } catch (e) {}
  }

  filterProducts(String name) async {
    try {
      isLoadingProducts = true;
      var data = await http.put(
        Uri.parse(
          '$backendUrl/filterProducts',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'type': name,
        }),
      );
      Iterable list = await json.decode(data.body);
      var productsData = List<Product>.from(
        list.map((e) => Product.fromJson(e)),
      );
      _products = productsData;
      isLoadingProducts = false;
      notifyListeners();
    } catch (e) {}
  }

  addProductToCart(Product product) {
    CartProductModel cartPrd = Util.createCartModel(product, quantity);
    if (_cart.where((cartEl) => cartEl.id == selectedProduct).isEmpty) {
      cartPrd.quantity = quantity;
      _cart.add(cartPrd);
    } else {
      cartPrd.quantity = quantity + cartPrd.quantity;
    }
    selectedProduct = null;
    notifyListeners();
  }

  addProductToFavorites(Product product) {
    product.isLiked = !product.isLiked;
    if (_favorites.where((favEl) => favEl.id == product.id).isEmpty) {
      _favorites.add(product);
    } else {
      _favorites.removeWhere((favorite) => favorite.id == product.id);
    }

    notifyListeners();
  }

  changeQuantityOfProduct(
      CartProductModel product, bool isUpading, bool isSubstract) {
    if (isUpading) {
      CartProductModel cartProduct =
          _cart[_cart.indexWhere((prd) => prd.id == product.id)];
      cartProduct.quantity = cartProduct.quantity = isSubstract
          ? cartProduct.quantity <= 1
              ? 1
              : cartProduct.quantity - 1
          : cartProduct.quantity + 1;
      notifyListeners();
      return;
    }
    quantity = isSubstract
        ? quantity = quantity <= 1 ? 1 : quantity - 1
        : quantity + 1;
    notifyListeners();
  }

  removeProductFromCart(CartProductModel product) {
    _cart.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  addCommentToProduct(id, String comment, String name, BuildContext ctx) async {
    var userProvider = Provider.of<UserProvider>(ctx, listen: false);
    _products[_products.indexWhere((element) => element.id == id)]
        .comments
        ?.insert(
            0,
            Comment(
              comment: comment,
              user: userProvider.user!.email,
              id: id,
              rating: 2,
            ));

    await http.post(
      Uri.parse(
        '$backendUrl/comments',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'id': id, "comment": comment, "user": name}),
    );
    notifyListeners();
  }
}
