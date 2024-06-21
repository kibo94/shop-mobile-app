import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/dialogs/make_impression_dialog.dart';
import 'package:my_app/ui/product_comment.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  const Comments({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getProductComments(context),
    );
  }

  Column getProductComments(BuildContext context) {
    var dataProvider = Provider.of<ProductProvider>(context, listen: true);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var singleProduct =
        dataProvider.products.singleWhere((prd) => prd.id == product.id);
    List<Widget> children = [];
    singleProduct.comments?.forEach(
      (comment) => children.add(
        ProductComment(comment: comment),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () async => {
              await showDialog(
                  context: context,
                  builder: (context) => MakeImpressionDialog(
                        productId: singleProduct.id,
                      ))
            },
            child: userProvider.user != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Add impression",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                decoration: TextDecoration.underline,
                                color: shopAction),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/images/fire.svg',
                        color: shopAction,
                      )
                    ],
                  )
                : null,
          ),
        ),
        ...children
      ],
    );
  }
}
