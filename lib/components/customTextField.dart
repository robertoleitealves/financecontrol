import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData icon;
  final EdgeInsets padding;
  final TextInputType keyboardType ;

  const CustomTextField({
    Key? key,
    this.controller,
    required this.label,
    required this.icon,
    this.padding = EdgeInsets.zero,
    this.keyboardType = TextInputType.multiline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
