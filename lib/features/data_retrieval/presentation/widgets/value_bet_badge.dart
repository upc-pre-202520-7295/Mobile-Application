// lib/features/data_retrieval/presentation/widgets/value_bet_badge.dart

import 'package:flutter/material.dart';

class ValueBetBadge extends StatelessWidget {
  const ValueBetBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF00D9A3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.arrow_upward,
            size: 16,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            'Value Bet',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
