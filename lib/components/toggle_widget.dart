import 'package:flutter/material.dart';

class DrinkToggle extends StatefulWidget {
  const DrinkToggle({super.key});

  @override
  State<DrinkToggle> createState() => _DrinkToggleState();
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
          duration: const Duration(milliseconds: 500),
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
