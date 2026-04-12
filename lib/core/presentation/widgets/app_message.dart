import 'package:flutter/material.dart';

import '../theme/app_semantic_colors.dart';

class AppMessage {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  static void error(BuildContext context, {required String message}) {
    AppMessage.show(
      context,
      message: message,
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }

  static void success(BuildContext context, {required String message}) {
    final colors = Theme.of(context).extension<AppSemanticColors>()!;
    AppMessage.show(context, message: message, backgroundColor: colors.success);
  }
}
