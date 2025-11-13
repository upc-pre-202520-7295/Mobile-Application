// lib/features/favorite_teams/presentation/widgets/favorite_team_card.dart

import 'package:flutter/material.dart';

class FavoriteTeamCard extends StatelessWidget {
  final String teamName;
  final String league;
  final String initials;
  final Color teamColor;
  final VoidCallback onRemove;

  const FavoriteTeamCard({
    Key? key,
    required this.teamName,
    required this.league,
    required this.initials,
    required this.teamColor,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Team Avatar
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: teamColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: teamColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Team Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teamName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A1F3D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    league,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Following Badge
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Color(0xFF00D9A3),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 13,
                          color: const Color(0xFF00D9A3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Favorite Star Icon
            IconButton(
              icon: const Icon(
                Icons.star,
                color: Color(0xFF00D9A3),
                size: 28,
              ),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
