// lib/features/data_retrieval/presentation/screens/match_details_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/presentation/widgets/top_bar.dart';
import '../../../shared/presentation/widgets/bottom_navigation_bar.dart';
import '../providers/match_provider.dart';
import '../widgets/team_badge.dart';
import '../widgets/value_bet_badge.dart';
import '../widgets/match_info_section.dart';

class MatchDetailsScreen extends ConsumerStatefulWidget {
  const MatchDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends ConsumerState<MatchDetailsScreen> {
  int _currentNavIndex = 5;

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(matchesProvider);
    final match = matchesState.selectedMatch;

    if (match == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Match Details')),
        body: const Center(child: Text('No match selected')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: TopBar(
        title: 'Betalyze',
        onNotificationTap: () => _showSnackBar('Notifications'),
        onSettingsTap: () => _showSnackBar('Settings'),
        onProfileTap: () => _showSnackBar('Profile'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Match Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1F3D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Comprehensive analysis and prediction details for the selected match',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A6FA5).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            match.league,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4A6FA5),
                            ),
                          ),
                        ),
                        const ValueBetBadge(),
                      ],
                    ),

                    const SizedBox(height: 24),

                    TeamBadge(
                      teamName: match.homeTeam.name,
                      initials: _getInitials(match.homeTeam.name),
                      color: const Color(0xFF6CABDD),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 24),

                    MatchInfoSection(
                      date: DateTime.parse(match.matchDate),
                      venue: 'Etihad Stadium',
                    ),

                    const SizedBox(height: 24),

                    TeamBadge(
                      teamName: match.awayTeam.name,
                      initials: _getInitials(match.awayTeam.name),
                      color: const Color(0xFFE74C3C),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Away',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              _buildPredictionSection(),
              const SizedBox(height: 24),
              _buildStatisticsSection(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BetalyzeBottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          _handleNavigation(index);
        },
      ),
    );
  }

  Widget _buildPredictionSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prediction',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A1F3D),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProbability('Home', '45%', const Color(0xFF4A6FA5)),
              _buildProbability('Draw', '25%', Colors.grey),
              _buildProbability('Away', '30%', const Color(0xFFE74C3C)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProbability(String label, String percentage, Color color) {
    return Column(
      children: [
        Text(
          percentage,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Head to Head',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A1F3D),
            ),
          ),
          const SizedBox(height: 16),
          _buildStatRow('Last 5 Meetings', '3-1-1'),
          _buildStatRow('Average Goals', '2.8 per match'),
          _buildStatRow('Last Winner', 'Manchester City'),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A1F3D),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String teamName) {
    final words = teamName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return teamName.substring(0, 2).toUpperCase();
  }

  void _handleNavigation(int index) {
    if (index != 5) {
      Navigator.pop(context);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF00D9A3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
