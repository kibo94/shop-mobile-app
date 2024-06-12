import 'package:flutter/material.dart';
import 'package:my_app/style/theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.onDone,
      this.btnColor = shopAction,
      required this.btnName,
      this.width});
  final Function onDone;
  final Color? btnColor;
  final String btnName;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onDone(),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(width: 0, color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            color: btnColor),
        child: Column(
          children: [
            Text(
              btnName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
