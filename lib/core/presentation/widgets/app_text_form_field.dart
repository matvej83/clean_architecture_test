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
    this.onTap,
    this.focusNode,
    this.unfocusOnTapOutside = true,
  });

  final TextEditingController controller;
  final bool? enabled;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? labelText;
  final InputDecoration? decoration;
  final Widget? prefix;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool unfocusOnTapOutside;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText ?? false,
      enabled: enabled,
      onTap: onTap,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      decoration:
          decoration ?? InputDecoration(labelText: labelText, prefix: prefix),
      onTapOutside: unfocusOnTapOutside
          ? (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          : null,
      validator: validator,
    );
  }
}
