import 'package:flutter/material.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/button.dart';
import 'package:my_app/ui/input_field.dart';
import 'package:my_app/ui/product_rating.dart';
import 'package:my_app/utils/util.dart';
import 'package:provider/provider.dart';

class MakeImpressionDialog extends StatefulWidget {
  const MakeImpressionDialog({
    required this.productId,
    super.key,
  });
  final int productId;

  @override
  State<MakeImpressionDialog> createState() => _MakeImpressionDialogState();
}

class _MakeImpressionDialogState extends State<MakeImpressionDialog> {
  final TextEditingController commentController = TextEditingController();
  String errorMessage = "";
  int rating = 1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: shopPrimary,
      contentPadding:
          const EdgeInsets.only(top: 39, bottom: 39, right: 21, left: 21),
      insetPadding: const EdgeInsets.symmetric(horizontal: 22),
      content: Container(
        height: 293,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: shopPrimary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 229,
              child: Text(
                textAlign: TextAlign.center,
                "Make your impresion about this product",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            InputField(
                isPassword: false,
                placeHolder: "Enter your comment",
                controller: commentController,
                errorMessage: errorMessage,
                onChange: (String value) => {
                      setState(() {
                        errorMessage = Util.validateInputField(value, 10);
                      })
                    }),
            const SizedBox(
              height: 23,
            ),
            Rating(
              rating: rating,
              onRate: (int rtn) => {
                setState(() {
                  rating = rtn;
                })
              },
            ),
            const SizedBox(
              height: 23,
            ),
            ActionButton(
              btnName: "Add impresion",
              btnColor: shopAction,
              width: 203,
              height: 43,
              onDone: () => {
                if (errorMessage.isEmpty)
                  {
                    // add impression
                    _addCommnetToProduct(context)
                  }
              },
            ),
          ],
        ),
      ),
    );
  }

  _addCommnetToProduct(BuildContext ctx) {
    var dataProvider = Provider.of<ProductProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    dataProvider.addCommentToProduct(
      widget.productId,
      commentController.text,
      userProvider.user!.email,
      rating,
      ctx,
    );
    commentController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      Util.snackBar(
        "The impression has been added",
        context,
      ),
    );
    Navigator.of(context).pop();
  }
}
