// lib/features/favorite_teams/presentation/screens/favorites_screen.dart

import 'package:betalyze_mobile/features/favorites/presentation/riverpod/favorite_teams_provider.dart';
import 'package:betalyze_mobile/features/favorites/presentation/widgets/favorite_team_card.dart';
import 'package:betalyze_mobile/features/shared/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  // ← NUEVO

class FavoritesScreen extends ConsumerStatefulWidget {  // ← CAMBIO: ConsumerStatefulWidget
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();  // ← CAMBIO
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {  // ← CAMBIO
  //int _currentNavIndex = 4;

  @override
  void initState() {
    super.initState();
    // Cargar equipos al iniciar (opcional para simular loading)
    // Future.microtask(() => ref.read(favoriteTeamsProvider.notifier).loadTeams());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favoriteTeamsProvider);  // ← LEER STATE DE RIVERPOD

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: TopBar(
        title: 'Betalyze',
        onNotificationTap: () => _showSnackBar('Notifications clicked'),
        onSettingsTap: () => _showSnackBar('Settings clicked'),
        onProfileTap: () => _showSnackBar('Profile clicked'),
      ),

      body: state.isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00D9A3),
        ),
      )
          : state.teams.isEmpty
          ? _buildEmptyState()
          : _buildTeamsList(state),


    );
  }

  Widget _buildTeamsList(FavoriteTeamsState state) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Favorites & Preferences',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A1F3D),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your favorite teams and customize your experience',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Your Favorite Teams',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A1F3D),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Teams List
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final team = state.teams[index];
                return FavoriteTeamCard(
                  teamName: team.name,
                  league: team.league,
                  initials: team.initials,
                  teamColor: team.color,
                  onRemove: () => _removeTeam(team.id, team.name),
                );
              },
              childCount: state.teams.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.star_outline,
                size: 60,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Favorite Teams Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Start adding your favorite teams to get\npersonalized predictions and insights',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _showSnackBar('Add team feature coming soon!'),
              icon: const Icon(Icons.add),
              label: const Text('Add Favorite Team'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D9A3),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeTeam(String teamId, String teamName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Remove Favorite Team'),
        content: Text(
          'Are you sure you want to remove $teamName from your favorites?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // ← USAR RIVERPOD PARA ELIMINAR
              ref.read(favoriteTeamsProvider.notifier).removeTeam(teamId);
              _showSnackBar('$teamName removed from favorites');
            },
            child: const Text(
              'Remove',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF00D9A3),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
