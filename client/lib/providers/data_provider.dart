import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_app/models/comment.dart';
import 'package:my_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DataProvider extends ChangeNotifier {
  List<Product> _products = [];
  int? selectedProduct;
  int quantity = 1;
  List<Product> _cart = [];
  List<Product> _favorites = [];
  List<Product> get products => _products;
  List<Product> get favorites => _favorites;
  List<Product> get cart => _cart;
  bool isLoadingProducts = false;

  setProduct(int? product) {
    selectedProduct = product;

    notifyListeners();
  }

  fetchProducts() async {
    isLoadingProducts = true;

    var data2 =
        await http.get(Uri.parse('https://192.168.0.103:4000/products'));
    Iterable list = await json.decode(data2.body);
    var productss = List<Product>.from(
      list.map((e) => Product.fromJson(e)),
    );

    _products = productss;
    isLoadingProducts = false;
    notifyListeners();
  }

  onAddToCartClickHanlder(Product product) {
    if (_cart.where((cartEl) => cartEl.id == selectedProduct).isEmpty) {
      product.quantity = quantity;
      _cart.add(product);
    } else {
      var prdQuantity =
          _cart[_cart.indexWhere((element) => element.id == selectedProduct)]
              .quantity;
      prdQuantity = quantity + prdQuantity;
      _cart[_cart.indexWhere((element) => element.id == selectedProduct)]
          .quantity = prdQuantity;
    }
    selectedProduct = null;

    notifyListeners();
  }

  onAddToFavorites(Product product) {
    product.isLiked = !product.isLiked;
    if (_favorites.where((favEl) => favEl.id == product.id).isEmpty) {
      _favorites.add(product);
    } else {
      _favorites.removeWhere((favorite) => favorite.id == product.id);
    }
    notifyListeners();
  }

  addOneToQuantity(Product product, bool isUpading) {
    if (isUpading) {
      var prdQuantity =
          _cart[_cart.indexWhere((element) => element.id == product.id)]
              .quantity;
      _cart[_cart.indexWhere((element) => element.id == product.id)].quantity =
          prdQuantity = prdQuantity + 1;
    }
    quantity = quantity + 1;
    notifyListeners();
  }

  subtractOneFromQuantity(Product product, bool isUpading) {
    if (isUpading) {
      var prdQuantity =
          _cart[_cart.indexWhere((element) => element.id == product.id)]
              .quantity;
      _cart[_cart.indexWhere((element) => element.id == product.id)].quantity =
          prdQuantity = prdQuantity <= 1 ? 1 : prdQuantity - 1;
    } else {
      quantity = quantity <= 1 ? 1 : quantity - 1;
    }

    notifyListeners();
  }

  removeProductFromCart(Product product) {
    _cart.removeWhere((element) => element.id == product.id);
    _products[_products.indexWhere((element) => element.id == product.id)]
        .quantity = 0;
    notifyListeners();
  }

  filterItems(String name) async {
    try {
      isLoadingProducts = true;
      var data = await http.put(
        Uri.parse(
          'https://192.168.0.103:4000/filterProducts',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'type': name,

          // Add any other data you want to send in the body
        }),
      );
      Iterable list = await json.decode(data.body);
      var productsData = List<Product>.from(
        list.map((e) => Product.fromJson(e)),
      );

      _products = productsData;
      isLoadingProducts = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addCommentToProduct(id, String comment, String name, BuildContext ctx) async {
    var userProvider = Provider.of<UserProvider>(ctx, listen: false);
    final Product product =
        _products[_products.indexWhere((element) => element.id == id)];
    _products[_products.indexWhere((element) => element.id == id)]
        .comments
        ?.insert(0,
            Comment(comment: comment, user: userProvider.user!.email, id: id));

    var data = await http.post(
      Uri.parse(
        'https://192.168.0.103:4000/comments',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        "comment": comment,
        "user": name

        // Add any other data you want to send in the body
      }),
    );
    notifyListeners();
  }
}