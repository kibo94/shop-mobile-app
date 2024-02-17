import 'package:flutter/material.dart';
import 'package:my_app/pages/register_page.dart';
import 'package:my_app/ui/loading_spinner.dart';
import 'package:my_app/ui/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _login(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(e.code);
      } else if (e.code == 'wrong-password') {
        print(e.code);
      }
      setState(() {
        isLoading = false;
      });
    }

    // if (formKey.currentState!.validate()) {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   await Future.delayed(const Duration(seconds: 3));
    //   setState(() {
    //     isLoading = false;
    //   });
    //   // ignore: use_build_context_synchronously

    // }
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
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 43, 42, 42),
                  size: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "READY TO SHOP ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                LoginForm(
                    buttonName: 'LOGIN',
                    login: ((email, password) => _login(email, password))),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Text('SIGN UP'),
                  onTap: () => _signUp(),
                ),
                if (isLoading) const CircularProgressIndicator()
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
