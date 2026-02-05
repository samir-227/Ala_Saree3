import 'package:flutter/material.dart';

class CheckoutTotalRow extends StatelessWidget {
  const CheckoutTotalRow({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('TOTAL', style: TextStyle(fontSize: 14, letterSpacing: 2)),
        Text(
          '£${totalPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 18,
            color: colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
