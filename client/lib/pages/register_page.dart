import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/ui/loading_spinner.dart';
import 'package:my_app/ui/login_form.dart';
import 'package:http/http.dart' as http;

var backendUrl = "https://shop-mobile-app-4.onrender.com";
// var backendUrl = "https://192.168.0.103:4000";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const routeName = '/register';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String errorTxt = '';
  _register(String email, String password) async {
    try {
      await http.post(
        Uri.parse(
          '${backendUrl}/register',
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

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isLoading = false;
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
                Text(
                  "Create your account",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 40,
                ),
                LoginForm(
                    buttonName: "Sign Up",
                    login: ((email, password, formKey) =>
                        _register(email, password))),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already hava a account?',
                      style: TextStyle(color: Color.fromRGBO(91, 91, 91, 1)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => _signIn(),
                      child: const Text('Sign in'),
                    )
                  ],
                ),
                if (isLoading) const CircularProgressIndicator(),
                if (errorTxt.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        errorTxt,
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
