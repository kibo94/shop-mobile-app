import 'package:flutter/material.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/ui/loading_spinner.dart';
import 'package:my_app/ui/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String errorTxt = '';
  _register(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      setState(() {
        isLoading = false;
        errorTxt = e.code;
      });
    }
  }

  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 227, 233),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
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
                const Icon(
                  Icons.app_registration_rounded,
                  color: Color.fromARGB(255, 43, 42, 42),
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                LoginForm(
                    buttonName: "REGISTER",
                    login: ((email, password) => _register(email, password))),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: const Text('SIGN IN'),
                  onTap: () => _signIn(),
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
