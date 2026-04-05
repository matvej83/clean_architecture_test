import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    this.enabled,
    this.obscureText,
    this.keyboardType,
    this.validator,
    this.labelText,
    this.decoration,
    this.prefix,
  });

  final TextEditingController controller;
  final bool? enabled;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? labelText;
  final InputDecoration? decoration;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      enabled: enabled,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      decoration:
          decoration ?? InputDecoration(labelText: labelText, prefix: prefix),
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: validator,
    );
  }
}
