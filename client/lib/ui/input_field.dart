import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/style/theme.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.isPassword,
      required this.placeHolder,
      required this.controller,
      required this.errorMessage,
      required this.onChange});
  final bool isPassword;
  final String placeHolder;
  final TextEditingController controller;
  final String errorMessage;
  final Function(String value) onChange;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            left: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: widget.errorMessage.isNotEmpty
                ? Border.all(width: 1, color: Colors.red)
                : null,
            color: shopSecondary,
          ),
          child: Stack(
            children: [
              TextFormField(
                obscureText: widget.isPassword ? hidePassword : false,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  height: 1,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Color.fromRGBO(126, 120, 120, 1)),
                  border: InputBorder.none,
                  hintText: widget.placeHolder,
                ),
                controller: widget.controller,
                onChanged: (value) {
                  widget.onChange(value);
                  // setState(() {
                  //   if (value.length >= widget.length) {
                  //     message = "";
                  //   } else {
                  //     message = widget.errorMessage;
                  //   }
                  // });
                },
              ),
              Positioned(
                right: 10,
                top: 10,
                child: widget.isPassword
                    ? GestureDetector(
                        onTap: () => setState(() {
                              hidePassword = !hidePassword;
                            }),
                        child: SvgPicture.asset(hidePassword
                            ? "assets/images/eye-hide.svg"
                            : 'assets/images/eye.svg'))
                    : const SizedBox(),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        if (widget.errorMessage.isNotEmpty)
          Text(
            widget.errorMessage,
            style: const TextStyle(
                color: Color.fromARGB(255, 225, 47, 47),
                fontWeight: FontWeight.w600),
          ),
      ],
    );
  }
}
