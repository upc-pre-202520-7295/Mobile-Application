// lib/features/betting_insights/presentation/widgets/value_badge.dart

import 'package:flutter/material.dart';

class ValueBadge extends StatelessWidget {
  final double percentage;

  const ValueBadge({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF00D9A3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_upward,
            size: 12,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            '${percentage.toStringAsFixed(1)}% Value',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
