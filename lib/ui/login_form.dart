import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.login, required this.buttonName});
  final Function(String email, String password) login;
  final String buttonName;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
          const Text(
            "Email",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _inputWrapper(
            TextFormField(
              expands: false,
              style: const TextStyle(color: Colors.blue),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.blue),
                labelStyle: TextStyle(color: Colors.blue),
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
          const Text(
            "Password",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _inputWrapper(
            TextFormField(
              style: TextStyle(color: Colors.blue),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.blue),
                border: InputBorder.none,
                hintText: 'Enter your password',
              ),
              controller: passwordController,
              validator: (String? value) {
                if (value == null || value.length < 3) {
                  setState(() {
                    passwordErrText = "Please enter some password";
                  });
                  return 'Please enter some password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => widget.login(
              emailController.text,
              passwordController.text,
            ),
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: -5.0,
                        blurRadius: 10.0,
                      ),
                    ],
                    border: Border.all(width: 0, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 29, 59, 228)),
                child: Column(
                  children: [
                    Text(
                      widget.buttonName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Container _inputWrapper(Widget child) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: child,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              spreadRadius: -5.0,
              blurRadius: 10.0,
            ),
          ]
          // boxShadow: [BoxShadow(color: Color.fromARGB(255, 75, 47, 47))],
          ),
    );
  }
}
