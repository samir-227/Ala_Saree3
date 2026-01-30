import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../controller/cart_provider.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Text(
                  'PAYMENT SUCCESS',
                  style: TextStyle(fontSize: 14, letterSpacing: 2, color: colorScheme.onSurface),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 18, color: colorScheme.onSurface),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.successBackground,
              child: Icon(Icons.check, color: AppColors.successForeground, size: 28),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Your payment was success',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                'Payment ID 15263541',
                style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Center(
              child: Text('Rate your purchase', style: TextStyle(fontSize: 13, color: colorScheme.onSurface)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sentiment_dissatisfied_outlined, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 16),
                Icon(Icons.sentiment_neutral_outlined, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 16),
                Icon(Icons.sentiment_satisfied_outlined, color: colorScheme.onSurfaceVariant),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().clear();
                      Navigator.of(context).pop();
                      context.go(AppRouter.main);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.inverseSurface,
                      foregroundColor: colorScheme.onInverseSurface,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text('SUBMIT', style: TextStyle(fontSize: 13)),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<CartProvider>().clear();
                      Navigator.of(context).pop();
                      context.go(AppRouter.main);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: colorScheme.onSurface),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text(
                      'BACK TO HOME',
                      style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
