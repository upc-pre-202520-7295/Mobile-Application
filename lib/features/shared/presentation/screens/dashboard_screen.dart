
import 'package:betalyze_mobile/features/shared/presentation/screens/main_navigation_screen.dart';
import 'package:betalyze_mobile/features/shared/presentation/widgets/quick_action_card.dart';
import 'package:betalyze_mobile/features/shared/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: TopBar(
        title: 'Betalyze',
        onNotificationTap: () => _showSnackBar(context, 'Notifications'),
        onSettingsTap: () => _showSnackBar(context, 'Settings'),
        onProfileTap: () => _showSnackBar(context, 'Profile'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1F3D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome back! Explore predictions and insights',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 32),

              // Quick Stats Cards
              _buildQuickStatsRow(),

              const SizedBox(height: 32),

              // Section Title
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A1F3D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Navigate to different sections',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 20),

              // Quick Action Cards Grid
              QuickActionCard(
                icon: Icons.trending_up,
                iconColor: const Color(0xFF00D9A3),
                title: 'Value Bets',
                description: 'ML-identified betting opportunities with high value',
                gradientColors: const [Color(0xFF21D4FD), Color(0xFFB721FF)],
                badge: 'HOT',
                onTap: () {
                  ref.read(navigationIndexProvider.notifier).state = 1;
                },
              ),


              const SizedBox(height: 12),

              QuickActionCard(
                icon: Icons.filter_alt,
                iconColor: const Color(0xFF00D9A3),
                title: 'Filters & Search',
                description: 'Find matches by team, league, or conditions',
                gradientColors: const [Color(0xFF11998e), Color(0xFF38ef7d)],
                onTap: () {
                  ref.read(navigationIndexProvider.notifier).state = 2;
                },
              ),

              const SizedBox(height: 12),

              QuickActionCard(
                icon: Icons.star,
                iconColor: const Color(0xFFFFA726),
                title: 'Favorites',
                description: 'Manage your favorite teams and preferences',
                gradientColors: const [Color(0xFFf093fb), Color(0xFFf5576c)],
                onTap: () {
                  ref.read(navigationIndexProvider.notifier).state = 3;
                },
              ),

              const SizedBox(height: 12),


              QuickActionCard(
                icon: Icons.bar_chart,
                iconColor: const Color(0xFFFF6B6B),
                title: 'Statistics',
                description: 'Deep dive into match and team statistics',
                gradientColors: const [Color(0xFFee0979), Color(0xFFff6a00)],
                onTap: () {
                  ref.read(navigationIndexProvider.notifier).state = 4;
                },
              ),


              const SizedBox(height: 32),

              // Coming Soon Section
              _buildComingSoonSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle_outline,
            value: '67.8%',
            label: 'Accuracy',
            color: const Color(0xFF00D9A3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.timeline,
            value: '24',
            label: 'This Week',
            color: const Color(0xFF4A6FA5),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.trending_up,
            value: '+12%',
            label: 'ROI',
            color: const Color(0xFFFFA726),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoonSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0A1F3D).withOpacity(0.9),
            const Color(0xFF00D9A3).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.rocket_launch,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'More Features Coming Soon',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Live match tracking, AI insights, and more!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF00D9A3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
