import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  double _currentPage = 0;

  String _nameOnCard = 'Iris Watson';
  String _cardNumber = '2365 3654 2365 3698';
  String _expMonth = '03';
  String _expYear = '25';

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
        centerTitle: true,
        title: const Text(
          'PAYMENT METHOD',
          style: TextStyle(letterSpacing: 2, fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 210,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  final colors = AppColors.cardPreviewBackgrounds;
                  final scale = 1 - (_currentPage - index).abs() * 0.08;
                  return Transform.scale(
                    scale: scale.clamp(0.9, 1.0),
                    child: _CreditCardPreview(
                      background: colors[index],
                      name: _nameOnCard,
                      cardNumber: _cardNumber,
                      expText: '$_expMonth/$_expYear',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isActive = (_currentPage.round() == index);
                return Container(
                  width: isActive ? 8 : 6,
                  height: isActive ? 8 : 6,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isActive
                            ? colorScheme.tertiary
                            : colorScheme.outlineVariant,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            _LinedTextField(
              label: 'Name On Card',
              initialValue: _nameOnCard,
              onChanged: (value) {
                setState(() {
                  _nameOnCard = value.isEmpty ? 'Name Surname' : value;
                });
              },
            ),
            const SizedBox(height: 16),
            _LinedTextField(
              label: 'Card Number',
              initialValue: _cardNumber,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final trimmed = value.replaceAll(' ', '');
                final grouped = trimmed.replaceAllMapped(
                  RegExp(r'.{1,4}'),
                  (m) => '${m.group(0)} ',
                );
                setState(() {
                  _cardNumber =
                      grouped.trim().isEmpty
                          ? '0000 0000 0000 0000'
                          : grouped.trim();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _LinedTextField(
                    label: 'Exp Month',
                    initialValue: _expMonth,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _expMonth = value.isEmpty ? '00' : value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _LinedTextField(
                    label: 'Exp Date',
                    initialValue: _expYear,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _expYear = value.isEmpty ? '00' : value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _LinedTextField(label: 'CVV'),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: colorScheme.inverseSurface,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                context.pop(); // close after "adding" card
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: colorScheme.inverseSurface,
                foregroundColor: colorScheme.onInverseSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                'ADD CARD',
                style: TextStyle(letterSpacing: 2, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreditCardPreview extends StatelessWidget {
  const _CreditCardPreview({
    required this.background,
    required this.name,
    required this.cardNumber,
    required this.expText,
  });

  final Color background;
  final String name;
  final String cardNumber;
  final String expText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onCard = colorScheme.onInverseSurface;
    final onCardMuted = colorScheme.onInverseSurface.withValues(alpha: 0.7);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.error,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: onCard,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                cardNumber,
                style: TextStyle(color: onCard, fontSize: 16, letterSpacing: 2),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CARD HOLDER',
                style: TextStyle(color: onCardMuted, fontSize: 10),
              ),
              Text(expText, style: TextStyle(color: onCard, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LinedTextField extends StatelessWidget {
  const _LinedTextField({
    required this.label,
    this.initialValue,
    this.onChanged,
    this.keyboardType,
  });

  final String label;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller:
          initialValue != null
              ? TextEditingController(text: initialValue)
              : null,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 12,
          color: colorScheme.onSurfaceVariant,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface),
        ),
        isDense: true,
      ),
      keyboardType:
          keyboardType ??
          (label == 'Card Number' ? TextInputType.number : TextInputType.text),
    );
  }
}
