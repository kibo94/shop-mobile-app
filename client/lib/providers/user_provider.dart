import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_app/models/cart_product.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

var backendUrl = "https://shop-mobile-app-4.onrender.com";

// var backendUrl = "https://192.168.0.103:4000";

class UserProvider extends ChangeNotifier {
  User? user;
  bool isLoading = false;
  String errorMessage = "";
  bool isUserOnline = true;

  setUser(User? userr) {
    user = userr;
  }

  setUserOnline(bool isOnline) {
    isUserOnline = isOnline;
    notifyListeners();
  }

  registerTheUser(String email, String password, String fullName, String city,
      String address, String phone, BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse(
          '$backendUrl/register',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'fullName': fullName,
          'city': city,
          'address': address,
          'phone': phone,
          // Add any other data you want to send in the body
        }),
      );
      if (res.statusCode == 404) {
        isLoading = false;

        errorMessage = "User exsits";
        notifyListeners();
      } else {
        errorMessage = "";
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => const LoginPage())),
        );
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }

  loginTheUser(String email, String password, BuildContext context) async {
    isLoading = true;

    try {
      var res = await http.post(
        Uri.parse(
          '$backendUrl/login',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,

          // Add any other data you want to send in the body
        }),
      );
      var user = UserResponse.fromJson(
        json.decode(res.body),
      );
      setUser(user.user);
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => const MyHomePage())),
        );
      }

      errorMessage = "";
      if (res.statusCode == 404) {
        isLoading = false;

        errorMessage = "User not found";
        notifyListeners();
      }

      isLoading = false;
    } on SocketException catch (platformError) {
      if (platformError.message ==
          "Failed host lookup: 'shop-mobile-app-4.onrender.com'") {
        ScaffoldMessenger.of(context).showSnackBar(
          Util.snackBar(platformError.message, context),
        );
      }
    } catch (e) {
      isLoading = false;
    }
    notifyListeners();
  }

  checkout(List<CartProductModel> products, BuildContext context) async {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);

    final jsonProducts =
        jsonEncode(products.map((product) => product.toJson()).toList());

    try {
      await http
          .post(
            Uri.parse(
              '$backendUrl/createReceipt',
            ),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              "email": user!.email,
              "products": jsonProducts
            })

            // Add any other data you want to send in the body
            ,
          )
          .then((value) async => {
                ScaffoldMessenger.of(context).showSnackBar(
                  Util.snackBar("Hvala na kupovini kod nas...", context),
                ),
                await dataProvider.resetCart()
              });
    } catch (e) {
      print(e);
    }
  }
}
