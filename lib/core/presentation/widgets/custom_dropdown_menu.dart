import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.entries,
    this.leadingIcon,
    this.trailingIcon,
  });

  final T initialValue;
  final ValueChanged<T?> onChanged;
  final List<DropdownMenuEntry<T>> entries;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: initialValue,
      onSelected: (T? value) {
        if (value != null) {
          onChanged(value);
        }
      },
      dropdownMenuEntries: entries,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
    );
  }
}
