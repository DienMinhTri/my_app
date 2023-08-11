// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ItemStatusProfile extends StatelessWidget {
  final String title;
  final Color color;
  final Function()? onPress;
  final bool isSelected;

  const ItemStatusProfile({
    super.key,
    required this.title,
    required this.color,
    this.onPress,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(isSelected ? 1 : 0.8),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(isSelected ? 1 : 0.1),
              spreadRadius: isSelected ? 0.5 : 1,
              blurRadius: isSelected ? 12 : 1,// changes position of shadow
              offset: isSelected ? Offset(0, 5) : Offset(0, 0)
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(isSelected ? 1 : 0.6),
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
