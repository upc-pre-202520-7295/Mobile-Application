// lib/features/betting_insights/presentation/widgets/value_bet_card.dart

import 'package:flutter/material.dart';
import '../../domain/entities/value_bet.dart';
import 'confidence_badge.dart';
import 'value_badge.dart';

class ValueBetCard extends StatelessWidget {
  final ValueBet valueBet;

  const ValueBetCard({
    super.key,
    required this.valueBet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: League + Badges
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // League Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getLeagueColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    valueBet.league,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _getLeagueColor(),
                    ),
                  ),
                ),

                Row(
                  children: [
                    ConfidenceBadge(level: valueBet.confidenceLevel),
                    const SizedBox(width: 8),
                    ValueBadge(percentage: valueBet.valuePercentage),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Teams
            Row(
              children: [
                Expanded(
                  child: Text(
                    valueBet.homeTeam,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A1F3D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'vs',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    valueBet.awayTeam,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A1F3D),
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Date
            Text(
              _formatDate(valueBet.matchDate),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 12),

            // Stats Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Outcome
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Outcome',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        valueBet.outcome,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A1F3D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Our Probability
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Our Probability',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${valueBet.ourProbability}%',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A1F3D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Bookmaker Odds
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bookmaker Odds',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        valueBet.bookmakerOdds.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A1F3D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Implied Probability
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Implied Prob.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${valueBet.impliedProbability}%',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A1F3D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getLeagueColor() {
    switch (valueBet.league) {
      case 'Premier League':
        return const Color(0xFF3D195B);
      case 'La Liga':
        return const Color(0xFFFF4E50);
      case 'Bundesliga':
        return const Color(0xFFD20515);
      case 'Serie A':
        return const Color(0xFF024494);
      case 'Ligue 1':
        return const Color(0xFF0B3D91);
      default:
        return const Color(0xFF4A6FA5);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
