// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ItemPriority extends StatelessWidget {
  final String title;
  final Color color;
  final Function()? onPress;

  ItemPriority({
    Key? key,
    required this.title,
    required this.color,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 40,
        width: 80,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: color == Colors.white ? Colors.black : Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
