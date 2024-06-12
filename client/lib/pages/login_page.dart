import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/pages/register_page.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/login_register_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = "/login";

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
    userProvider.loginTheUser(email, password, context);
  }

  bool isLoading = false;
  String errorMessage = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
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
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(
                    height: 48,
                  ),
                  LoginRegisterForm(
                      buttonName: 'Sign in',
                      login: ((email, password, formKey) =>
                          _login(email, password, formKey))),
                  const SizedBox(
                    height: 15,
                  ),
                  if (userProvider.errorMessage.isNotEmpty)
                    Text(
                      userProvider.errorMessage,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 225, 47, 47),
                          fontWeight: FontWeight.w600),
                    ),
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
                        onTap: () => _signUp(userProvider),
                        child: const Text('Sign up'),
                      )
                    ],
                  ),
                  if (isLoading)
                    const CircularProgressIndicator(
                      color: shopAction,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _signUp(UserProvider userProvider) {
    userProvider.errorMessage = "";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }
}
