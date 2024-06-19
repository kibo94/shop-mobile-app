import 'package:flutter/material.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/button.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog(
      {super.key,
      required this.title,
      required this.onYes,
      required this.onNo});
  final Function onYes;
  final Function onNo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: shopSecondary,
      contentPadding: const EdgeInsets.only(top: 39, bottom: 39),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      content: Container(
        height: 166,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: shopSecondary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  btnName: "Yes",
                  height: 43,
                  btnColor: shopAction,
                  width: 120,
                  onDone: () => onYes(),
                ),
                const SizedBox(
                  width: 41,
                ),
                ActionButton(
                  btnName: "No",
                  height: 43,
                  btnColor: shopPrimary,
                  textColor: Colors.black,
                  width: 120,
                  onDone: () => onNo(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
