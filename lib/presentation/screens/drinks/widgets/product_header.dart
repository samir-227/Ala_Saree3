import 'package:flutter/material.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({
    super.key,
    required this.name,
    this.title,
    this.description,
    required this.price,
  });

  final String name;
  final String? title;
  final String? description;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (title != null)
              Text(title!)
            else if (description != null)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        Text(
          '£$price',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
