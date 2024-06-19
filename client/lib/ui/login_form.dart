import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/button.dart';
import 'package:my_app/ui/input_field.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.login, required this.buttonName});
  final Function(String email, String password, GlobalKey<FormState> formKey)
      login;
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
  bool hidePassword = true;
  bool loginFormValid = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 21,
          ),
          InputField(
            isPassword: false,
            placeHolder: "Enter your email",
            controller: emailController,
            errorMessage: emailErrText,
            onChange: (value) => {
              setState(() {
                emailErrText = Util.validateUserEmail(value);
              })
            },
          ),
          const SizedBox(
            height: 20,
          ),
          InputField(
            isPassword: true,
            placeHolder: "Enter your password",
            errorMessage: passwordErrText,
            controller: passwordController,
            onChange: (value) => {
              setState(() {
                passwordErrText = Util.validateInputField(value, 3);
              })
            },
          ),
          const SizedBox(
            height: 48,
          ),
          ActionButton(
            onDone: () {
              validateLoginForm();
              if (loginFormValid) {
                widget.login(
                    emailController.text, passwordController.text, _formKey);
              }
            },
            btnName: widget.buttonName,
          )
        ],
      ),
    );
  }

  validateLoginForm() {
    setState(() {
      emailErrText = Util.validateUserEmail(emailController.text);
      passwordErrText = Util.validateInputField(passwordController.text, 3);

      if (emailErrText.isEmpty && passwordErrText.isEmpty) {
        loginFormValid = true;
      }
    });
  }
}
