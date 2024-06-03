import 'package:flutter/material.dart';
import 'package:my_app/style/theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.onDone,
      this.btnColor = shopBlack,
      required this.btnName});
  final Function onDone;
  final Color? btnColor;
  final String btnName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onDone(),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
              color: btnColor),
          child: Column(
            children: [
              Text(
                btnName,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.copyWith(color: Colors.white),
              )
            ],
          )),
    );
  }
}
