import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';

var backendUrl = "https://shop-mobile-app-4.onrender.com";

// var backendUrl = "https://192.168.0.103:4000";
class UserProvider extends ChangeNotifier {
  User? user;
  bool isLoading = false;
  String errorMessage = "";

  setUser(User? userr) {
    user = userr;
  }

  registerTheUser(String email, String password, BuildContext context) async {
    try {
      await http.post(
        Uri.parse(
          '$backendUrl/register',
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

      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => const LoginPage())),
      );

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
          MaterialPageRoute(
              builder: ((context) => const MyHomePage(
                    title: 'Home',
                  ))),
        );
      }

      if (res.statusCode == 404) {
        isLoading = false;

        errorMessage = "User not found";
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }
}
