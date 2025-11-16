// lib/core/presentation/main_navigation_screen.dart

import 'package:betalyze_mobile/features/betting_insights/presentation/screens/value_bets_screen.dart';
import 'package:betalyze_mobile/features/data_retrieval/presentation/screens/filters_search_screen.dart';
import 'package:betalyze_mobile/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:betalyze_mobile/features/shared/presentation/screens/dashboard_screen.dart';
import 'package:betalyze_mobile/features/shared/presentation/widgets/bottom_navigation_bar.dart';
import 'package:betalyze_mobile/features/shared/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Provider para manejar el índice de navegación
final navigationIndexProvider = StateProvider<int>((ref) => 0);

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const DashboardScreen(),
          const ValueBetsScreen(),
          const FiltersSearchScreen(),
          const FavoritesScreen(),
          _buildReportsScreen(),
        ],
      ),
      bottomNavigationBar: BetalyzeBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(navigationIndexProvider.notifier).state = index;
        },
      ),
    );
  }


  Widget _buildDashboardScreen() {
    return _buildPlaceholderScreen('Dashboard', Icons.dashboard, 0);
  }

  Widget _buildReportsScreen() {
    return _buildPlaceholderScreen('Statistics', Icons.bar_chart, 5);
  }

  Widget _buildPlaceholderScreen(String title, IconData icon, int index) {
    return Scaffold(
      appBar: TopBar(
        title: 'Betalyze',
        onNotificationTap: () {},
        onSettingsTap: () {},
        onProfileTap: () {},
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: const Color(0xFF00D9A3),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A1F3D),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Screen index: $index',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming soon...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
