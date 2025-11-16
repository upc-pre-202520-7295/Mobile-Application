// lib/features/data_retrieval/presentation/widgets/team_badge.dart

import 'package:flutter/material.dart';

class TeamBadge extends StatelessWidget {
  final String teamName;
  final String initials;
  final Color color;

  const TeamBadge({
    Key? key,
    required this.teamName,
    required this.initials,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              initials,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          teamName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0A1F3D),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
