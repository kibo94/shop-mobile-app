import 'package:flutter/material.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/ui/login_form.dart';
import 'package:my_app/ui/register_form.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const routeName = '/register';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  _register(
    String email,
    String password,
    String fullName,
    String city,
    String address,
    String phone,
  ) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.registerTheUser(
        email, password, fullName, city, address, phone, context);
  }

  bool isLoading = false;
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
                  Text(
                    "Create your account",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RegisterForm(
                      buttonName: "Sign Up",
                      register: ((email, password, fullName, city, address,
                              phone, formKey) =>
                          _register(email, password, fullName, city, address,
                              phone))),
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
                        'Already hava a account?',
                        style: TextStyle(color: Color.fromRGBO(91, 91, 91, 1)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () => _signIn(userProvider),
                        child: const Text('Sign in'),
                      )
                    ],
                  ),
                  if (isLoading) const CircularProgressIndicator(),
                  // if (errorTxt.isNotEmpty)
                  //   Column(
                  //     children: [
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       Text(
                  //         errorTxt,
                  //         style: const TextStyle(
                  //             color: Colors.red,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 18),
                  //       ),
                  //     ],
                  //   )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _signIn(UserProvider userProvider) {
    setState(() {
      userProvider.errorMessage = "";
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
