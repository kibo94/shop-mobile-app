import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({super.key, required this.filterItem});
  final Function(String name) filterItem;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _filter('All', widget.filterItem),
            _filter('Fruits', widget.filterItem),
            _filter('Laptops', widget.filterItem),
            _filter('Vegetables', widget.filterItem),
          ],
        ));
  }
}

GestureDetector _filter(String name, Function filterItem) {
  return GestureDetector(
    onTap: () => filterItem(name),
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(name),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
    ),
  );
}
