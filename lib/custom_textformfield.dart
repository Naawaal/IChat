import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextformField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CustomTextformField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction:
          hintText == 'Email' ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ).marginOnly(left: 5, right: 5, bottom: 5);
  }
}
