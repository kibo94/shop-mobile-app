import 'package:flutter/material.dart';
import 'package:my_app/style/theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.onDone,
      this.btnColor = shopAction,
      this.textColor,
      required this.btnName,
      this.theme,
      this.height,
      this.width});
  final Function onDone;
  final Color? btnColor;
  final String btnName;
  final TextStyle? theme;
  final double? width;
  final double? height;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onDone(),
      child: Container(
        alignment: Alignment.center,
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 57,
        decoration: BoxDecoration(
            border: Border.all(width: 0, color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            color: btnColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              btnName,
              style: theme ??
                  Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: textColor ?? Colors.white,
                        height: 1,
                      ),
            )
          ],
        ),
      ),
    );
  }
}
