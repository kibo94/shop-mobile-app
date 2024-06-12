import 'package:flutter/material.dart';

class ShopContainer extends StatelessWidget {
  const ShopContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: child,
    );
  }
}
