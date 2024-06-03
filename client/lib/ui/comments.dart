import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/data_provider.dart';
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
    var dataProvider = Provider.of<DataProvider>(context, listen: true);
    var singleProduct =
        dataProvider.products.singleWhere((prd) => prd.id == product.id);
    List<Widget> children = [];
    singleProduct.comments?.forEach(
      (comment) => children.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(bottom: 15, top: 15),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(
            color: shopGrey2,
            border: Border(
                left: BorderSide(
              width: 1,
              color: Colors.black,
            ))),
        child: Padding(
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
              Text(
                comment.comment,
                style: const TextStyle(
                  fontSize: 18,
                  color: shopGrey1,
                ),
              ),
            ],
          ),
        ),
      )),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
