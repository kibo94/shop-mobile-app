import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/register_page.dart';
import 'package:my_app/providers/products_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/login_form.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

var backendUrl = "https://shop-mobile-app-4.onrender.com";
// var backendUrl = "https://192.168.0.103:4000";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = "/";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class UserResponse {
  final User? user;

  UserResponse({
    required this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        user: json['user'] != null ? User.fromJson(json['user']) : null);
  }
}

class _LoginPageState extends State<LoginPage> {
  _login(String email, String password, formKey) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    // await http.post(Uri.parse('https://192.168.0.100:3000/send'));
    // var data = await http.get(Uri.parse('https://192.168.0.100:3000'));
    // var user = Profile.fromJson(json.decode(data.body));
    // var productss = List<Product>.from(
    //   list.map((e) => Product.fromJson(e)),
    // );

    setState(() {
      isLoading = true;
    });
    try {
      var res = await http.post(
        Uri.parse(
          '${backendUrl}/login',
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
      userProvider.setUser(user.user!);
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
        setState(() {
          isLoading = false;
        });
        setState(() {
          errorMessage = "User not found";
        });
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = false;
  String errorMessage = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Log in",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline1),
                const SizedBox(
                  height: 48,
                ),
                LoginForm(
                    buttonName: 'Sign in',
                    login: ((email, password, formKey) =>
                        _login(email, password, formKey))),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you hava a account?',
                      style: TextStyle(color: Color.fromRGBO(91, 91, 91, 1)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => _signUp(),
                      child: const Text('Sign up'),
                    )
                  ],
                ),
                if (isLoading)
                  const CircularProgressIndicator(
                    color: shopBlack,
                  ),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 225, 47, 47),
                        fontWeight: FontWeight.w600),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }
}
