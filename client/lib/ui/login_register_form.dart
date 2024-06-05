import 'package:flutter/material.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/button.dart';

class LoginRegisterForm extends StatefulWidget {
  const LoginRegisterForm(
      {super.key, required this.login, required this.buttonName});
  final Function(String email, String password, GlobalKey<FormState> formKey)
      login;
  final String buttonName;
  @override
  State<LoginRegisterForm> createState() => _LoginRegisterFormState();
}

class _LoginRegisterFormState extends State<LoginRegisterForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String emailErrText = '';
  String passwordErrText = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // const Text(
          //   "Email",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 18,
          //   ),
          // ),
          const SizedBox(
            height: 21,
          ),
          _inputWrapper(
            TextFormField(
              expands: false,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Color.fromRGBO(126, 120, 120, 1)),
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter your email',
                border: InputBorder.none,

                // errorBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.red, width: 1.0),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.blue, width: 1.0),
                // ),
              ),
              controller: emailController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    emailErrText = "Please enter some email";
                  });
                  return 'Please enter some email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // const Text(
          //   "Password",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 18,
          //   ),
          // ),
          // const SizedBox(
          //   height: 21,
          // ),
          // _inputWrapper(
          //   TextFormField(
          //     style: const TextStyle(
          //       color: Colors.black,
          //       fontSize: 18,
          //     ),
          //     decoration: const InputDecoration(
          //       hintStyle: TextStyle(color: Color.fromRGBO(126, 120, 120, 1)),
          //       border: InputBorder.none,
          //       hintText: 'Enter your password',
          //     ),
          //     controller: passwordController,
          //     validator: (String? value) {
          //       if (value == null || value.length < 3) {
          //         setState(() {
          //           passwordErrText = "Please enter some password";
          //         });
          //         return 'Please enter some password';
          //       }
          //       return null;
          //     },
          //   ),
          // ),
          // const SizedBox(
          //   height: 48,
          // ),
          ActionButton(
            onDone: () => widget.login(
                emailController.text, passwordController.text, _formKey)!,
            btnName: widget.buttonName,
          )
        ],
      ),
    );
  }

  Container _inputWrapper(Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(120, 137, 142, 0.25),
                offset: Offset(0, 1),
                blurRadius: 4,
                spreadRadius: 2),
          ]
          // boxShadow: [BoxShadow(color: Color.fromARGB(255, 75, 47, 47))],
          ),
      child: child,
    );
  }
}
