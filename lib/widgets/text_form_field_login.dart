import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  const TextFormFieldCustom({
    super.key,
    required this.controller,
    this.validator,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 183, 182, 182),
          ),
          contentPadding: const EdgeInsets.only(bottom: 1.0, left: 10)
              .add(const EdgeInsets.symmetric(horizontal: 10)),
          suffixIcon: const Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
