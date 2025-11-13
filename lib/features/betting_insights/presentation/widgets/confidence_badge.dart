// lib/features/betting_insights/presentation/widgets/confidence_badge.dart

import 'package:flutter/material.dart';

class ConfidenceBadge extends StatelessWidget {
  final String level;

  const ConfidenceBadge({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _getColor().withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        level,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _getColor(),
        ),
      ),
    );
  }

  Color _getColor() {
    switch (level) {
      case 'HIGH':
        return const Color(0xFF00D9A3);
      case 'MEDIUM':
        return const Color(0xFFFFA726);
      case 'LOW':
        return const Color(0xFF90A4AE);
      default:
        return const Color(0xFF90A4AE);
    }
  }
}
