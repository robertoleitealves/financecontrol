// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  Key? key;
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration = const InputDecoration();
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization = TextCapitalization.none;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign = TextAlign.start;
  final TextAlignVertical? textAlignVertical;
  final int? maxLines = 1;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final void Function(String, Map<String, dynamic>)? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry padding;
  final IconData icon;

  CustomTextField({
    Key? key,
    required this.label,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textAlignVertical,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    required this.padding,
    required this.icon,
  }) : super(key: key);

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
        onChanged: onChanged,
      ),
    );
  }
}
