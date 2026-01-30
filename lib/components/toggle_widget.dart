import 'package:flutter/material.dart';

/// toggle
class DrinkToggle extends StatefulWidget {
  @override
  @override
  _DrinkToggleState createState() => _DrinkToggleState();
}

class _DrinkToggleState extends State<DrinkToggle> {
  bool isIced = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          _buildToggleOption(context, "Hot", !isIced),
          _buildToggleOption(context, "Iced", isIced),
        ],
      ),
    );
  }

  Widget _buildToggleOption(BuildContext context, String label, bool selected) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isIced = label == "Iced";
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeIn,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

/// qty
class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key, this.onChanged});

  final ValueChanged<int>? onChanged;

  @override
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: colorScheme.scrim.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton("-", () {
            if (quantity > 1) {
              setState(() {
                quantity--;
              });
              widget.onChanged?.call(quantity);
            }
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "$quantity",
              style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
            ),
          ),
          _buildButton("+", () {
            setState(() {
              quantity++;
            });
            widget.onChanged?.call(quantity);
          }),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
