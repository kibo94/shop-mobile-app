import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/providers/product_provider.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...children],
    );
  }
}
