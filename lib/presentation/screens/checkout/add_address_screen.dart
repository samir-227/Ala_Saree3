import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
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
          'ADD SHIPPING ADRESS',
          style: TextStyle(letterSpacing: 2, fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _LinedField(
                    label: 'First name',
                    controller: _firstNameController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _LinedField(
                    label: 'Last name',
                    controller: _lastNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _LinedField(label: 'Address', controller: _addressController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _LinedField(
                    label: 'City',
                    controller: _cityController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _LinedField(
                    label: 'State',
                    controller: _stateController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _LinedField(
                    label: 'ZIP code',
                    controller: _zipController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _LinedField(
                    label: 'Phone number',
                    controller: _phoneController,
                  ),
                ),
              ],
            ),
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
                final name =
                    '${_firstNameController.text} ${_lastNameController.text}'
                        .trim();
                final addressLine = _addressController.text.trim();
                final cityStateZip =
                    '${_cityController.text} ${_stateController.text} ${_zipController.text}'
                        .trim();
                final phone = _phoneController.text.trim();

                context.pop(<String, String>{
                  'name': name.isEmpty ? 'Iris Watson' : name,
                  'address':
                      '$addressLine\n$cityStateZip'.trim().isEmpty
                          ? '606-3727 Ullamcorper. Street\nRoseville NH 11523'
                          : '$addressLine\n$cityStateZip',
                  'phone': phone.isEmpty ? '(786) 713-8616' : phone,
                });
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
                'ADD NOW',
                style: TextStyle(letterSpacing: 2, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LinedField extends StatelessWidget {
  const _LinedField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
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
    );
  }
}
