import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/comment.dart';
import 'package:my_app/style/theme.dart';

class ProductComment extends StatelessWidget {
  const ProductComment({super.key, required this.comment});
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
