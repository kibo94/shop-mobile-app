import 'package:flutter/material.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/ui/button.dart';
import 'package:my_app/ui/input_field.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm(
      {super.key, required this.register, required this.buttonName});
  final Function(String email, String password, String fullName, String city,
      String address, String phone, GlobalKey<FormState> formKey) register;
  final String buttonName;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameContrloler = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String emailErrText = '';
  String passwordErrText = '';
  String fullNameErrText = '';
  String cityErrText = '';
  String addressErrText = '';
  String phoneErrText = '';
  bool hidePassword = true;
  bool registerFormValid = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Container(
        height: 450,
        child: SingleChildScrollView(
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
              // ),aaaa
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
                height: 20,
              ),
              InputField(
                isPassword: false,
                placeHolder: "Enter your full name",
                errorMessage: fullNameErrText,
                controller: fullNameContrloler,
                onChange: (value) => {
                  setState(() {
                    fullNameErrText = Util.validateInputField(value, 3);
                  })
                },
              ),

              const SizedBox(
                height: 20,
              ),
              InputField(
                isPassword: false,
                placeHolder: "Enter your city",
                errorMessage: cityErrText,
                controller: cityController,
                onChange: (value) => {
                  setState(() {
                    cityErrText = Util.validateInputField(value, 3);
                  })
                },
              ),

              const SizedBox(
                height: 20,
              ),
              InputField(
                isPassword: false,
                placeHolder: "Enter your address",
                errorMessage: addressErrText,
                controller: addressController,
                onChange: (value) => {
                  setState(() {
                    addressErrText = Util.validateInputField(value, 3);
                  })
                },
              ),

              const SizedBox(
                height: 20,
              ),
              InputField(
                isPassword: false,
                placeHolder: "Enter your phone",
                errorMessage: phoneErrText,
                controller: phoneController,
                onChange: (value) => {
                  setState(() {
                    phoneErrText = Util.validateInputField(value, 3);
                  })
                },
              ),

              const SizedBox(
                height: 48,
              ),
              ActionButton(
                onDone: () => {
                  validateRegisterForm(),
                  if (registerFormValid)
                    {
                      widget.register(
                          emailController.text,
                          passwordController.text,
                          fullNameContrloler.text,
                          cityController.text,
                          addressController.text,
                          phoneController.text,
                          _formKey)!,
                    }
                },
                btnName: widget.buttonName,
              )
            ],
          ),
        ),
      ),
    );
  }

  validateRegisterForm() {
    setState(() {
      emailErrText = Util.validateUserEmail(emailController.text);
      passwordErrText = Util.validateInputField(passwordController.text, 3);
      fullNameErrText = Util.validateInputField(fullNameContrloler.text, 3);
      cityErrText = Util.validateInputField(cityController.text, 3);
      addressErrText = Util.validateInputField(addressController.text, 3);
      phoneErrText = Util.validateInputField(phoneController.text, 3);
      if (emailErrText.isEmpty &&
          passwordErrText.isEmpty &&
          fullNameErrText.isEmpty &&
          cityErrText.isEmpty &&
          addressErrText.isEmpty &&
          phoneErrText.isEmpty) {
        registerFormValid = true;
      }
    });
  }
}
