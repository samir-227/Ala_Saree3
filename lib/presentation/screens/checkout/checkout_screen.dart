import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_router.dart';
import '../../controller/cart_provider.dart';
import 'payment_success_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _name;
  String? _address;
  String? _phone;

  Future<void> _onAddAddressPressed() async {
    final result = await context.push<Map<String, String>?>(
      AppRouter.addAddress,
    );

    if (result != null) {
      setState(() {
        _name =
            result['name']?.trim().isEmpty == true
                ? _name
                : result['name'] ?? _name;
        _address = result['address'] ?? _address;
        _phone = result['phone'] ?? _phone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
        centerTitle: true,
        title: const Text(
          'CHECKOUT',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w500),
        ),
      ),
      body:
          items.isEmpty
              ? const Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 16),
                ),
              )
              : ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                children: [
                  const _SectionTitle('SHIPPING ADDRESS'),
                  const SizedBox(height: 8),
                  _ShippingAddressCard(
                    name: _name ?? 'Iris Watson',
                    address:
                        _address ??
                        '606-3727 Ullamcorper. Street\nRoseville NH 11523',
                    phone: _phone ?? '(786) 713-8616',
                    onAddPressed: _onAddAddressPressed,
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle('SHIPPING METHOD'),
                  const SizedBox(height: 8),
                  _PillRow(
                    label: 'Pickup at store',
                    trailing: 'FREE',
                    onTap: () {
                      _showSimpleSheet(
                        context,
                        title: 'Shipping method',
                        options: const [
                          'Pickup at store',
                          'Standard delivery',
                          'Express delivery',
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle('PAYMENT METHOD'),
                  const SizedBox(height: 8),
                  _PillRow(
                    label: 'Select payment method',
                    trailing: '',
                    onTap: () {
                      context.push(AppRouter.addCard);
                    },
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  // Order summary (simple)
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.product.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Size ${item.sizeLabel}  •  Qty ${item.quantity}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '£${item.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TOTAL',
                        style: TextStyle(fontSize: 14, letterSpacing: 2),
                      ),
                      Text(
                        '£${cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
      bottomNavigationBar: Container(
        color: colorScheme.inverseSurface,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed:
                  items.isEmpty
                      ? null
                      : () async {
                        await showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const PaymentSuccessDialog(),
                        );
                      },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor:
                    items.isEmpty
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.inverseSurface,
                foregroundColor: colorScheme.onInverseSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                'PLACE ORDER',
                style: TextStyle(letterSpacing: 2, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        letterSpacing: 1.5,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _ShippingAddressCard extends StatelessWidget {
  const _ShippingAddressCard({
    required this.name,
    required this.address,
    required this.phone,
    required this.onAddPressed,
  });

  final String name;
  final String address;
  final String phone;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$address\n$phone',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onAddPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            side: BorderSide(color: colorScheme.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          icon: const Icon(Icons.add, size: 18),
          label: const Text(
            'Add shipping address',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _PillRow extends StatelessWidget {
  const _PillRow({required this.label, required this.trailing, this.onTap});

  final String label;
  final String trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailing.isNotEmpty)
                  Text(
                    trailing,
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showSimpleSheet(
  BuildContext context, {
  required String title,
  required List<String> options,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      final colorScheme = Theme.of(ctx).colorScheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...options.map(
                (opt) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(opt),
                  onTap: () => Navigator.of(ctx).pop(),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
