import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/products_provider.dart';
import 'package:my_app/style/theme.dart';
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
    var dataProvider = Provider.of<ProductsProvider>(context, listen: true);
    var singleProduct =
        dataProvider.products.singleWhere((prd) => prd.id == product.id);
    List<Widget> children = [];
    singleProduct.comments?.forEach(
      (comment) => children.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(bottom: 20, top: 15),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color.fromRGBO(
                  0,
                  0,
                  0,
                  0.25,
                ),
              ),
            ]),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 17,
                right: 41,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.user),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    child: Text(
                      comment.comment,
                      style: const TextStyle(
                        fontSize: 18,
                        color: shopGrey1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 0,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: shopBlack,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Text(
                        comment.rating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        "assets/images/star.svg",
                        width: 15,
                        height: 14,
                        color: const Color.fromRGBO(251, 244, 74, 1),
                      ),
                    ],
                  )),
            )
          ],
        ),
      )),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...children],
    );
  }
}
