import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({super.key, required this.filterItem});
  final Function(String name) filterItem;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  String type = "All";
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

  GestureDetector _filter(String name, Function filterItem) {
    return GestureDetector(
      onTap: () => {
        filterItem(
          name,
        ),
        setState(() {
          type = name;
        })
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        margin: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            color: type == name
                ? Colors.black
                : const Color.fromRGBO(82, 82, 82, 0.21),
            borderRadius: BorderRadius.circular(5)),
        child: Text(name,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: type == name ? Colors.white : Colors.black,
                )),
      ),
    );
  }
}
