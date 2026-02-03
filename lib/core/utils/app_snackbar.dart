import 'package:flutter/material.dart';

class AppSnackBar {
  static void showSuccess(
    BuildContext context, {
    String message = 'Added to cart',
    Duration duration = const Duration(milliseconds: 500),
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _SnackBarContent(
          icon: Icons.check_circle,
          iconColor: colorScheme.onTertiary,
          textColor: colorScheme.onTertiary,
          message: message,
        ),
        backgroundColor: colorScheme.tertiary,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        duration: duration,
        elevation: 2,
      ),
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 1),
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _SnackBarContent(
          icon: Icons.error_outline,
          iconColor: colorScheme.onErrorContainer,
          textColor: colorScheme.onErrorContainer,
          message: message,
        ),
        backgroundColor: colorScheme.errorContainer,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        duration: duration,
        elevation: 2,
      ),
    );
  }
}

/// Reusable content widget
class _SnackBarContent extends StatelessWidget {
  const _SnackBarContent({
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.message,
  });

  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            message,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
