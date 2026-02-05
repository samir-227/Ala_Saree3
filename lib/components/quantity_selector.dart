import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _button("-", () {
          if (quantity > 1) onChanged(quantity - 1);
        }),
        Text(
          "$quantity",
          style: TextStyle(fontSize: 24, color: colorScheme.tertiary),
        ),
        _button("+", () => onChanged(quantity + 1)),
      ],
    );
  }

  Widget _button(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(label, style: const TextStyle(fontSize: 30)),
    );
  }
}
