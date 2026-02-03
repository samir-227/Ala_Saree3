import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  const DrinkCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.title,
    required this.price,
  });
  final String id;
  final String image;
  final String name;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: colorScheme.surface,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 70, horizontal: 3),
              child: Row(),
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 20,
          bottom: 45,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 70,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30,
                      spreadRadius: 2,
                      color: colorScheme.scrim.withValues(alpha: 0.54),
                    ),
                  ],
                ),
              ),
              Image.asset(image, fit: BoxFit.contain),
            ],
          ),
        ),
        Positioned(
          top: 70,
          bottom: 0,

          left: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '£$price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 50,
          bottom: 50,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.onSurface),
            ),
            child: Icon(
              Icons.arrow_forward_sharp,
              color: colorScheme.onSurfaceVariant,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
