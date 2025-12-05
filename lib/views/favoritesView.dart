import 'package:betalyze_mobile/services/favoriteClient.dart';
import 'package:flutter/material.dart';

import '../domain/FavoriteTeam.dart';
import 'widgets/favorite_team_card.dart';
import 'widgets/top_bar.dart' show TopBar;

var mockUserId = "64a4d231-0846-4d96-9dbc-82cd3789ec87";

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesView> {
  List<FavoriteTeam> _favoriteTeams = [];
  FavoriteTeamClient client = FavoriteTeamClient();

  void _updateFavoriteTeams() {

    var mockUserId = "64a4d231-0846-4d96-9dbc-82cd3789ec87";

    var userId = mockUserId;
    client.getFavoriteTeams(userId).then((value) {
      setState(() {
        _favoriteTeams = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _updateFavoriteTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: TopBar(
        title: 'Betalyze',
        onNotificationTap: () => _showSnackBar('Notifications clicked'),
        onSettingsTap: () => _showSnackBar('Settings clicked'),
        onProfileTap: () => _showSnackBar('Profile clicked'),
      ),

      body: _favoriteTeams.isEmpty
          ? _buildEmptyState()
          : _buildTeamsList(_favoriteTeams),


    );
  }

  Widget _buildTeamsList(List<FavoriteTeam> favoriteTeams) {
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
                final team = favoriteTeams[index];
                return FavoriteTeamCard(
                  favoriteTeam: team,
                  onRemove: () => _removeTeam(team.teamId, team.teamName),
                );
              },
              childCount: _favoriteTeams.length,
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
              var userId = mockUserId;
              client.addTeam(userId, teamId).then((value) {
                if (value) {
                  _showSnackBar('$teamName removed from favorites');
                } else {
                  _showSnackBar('Error removing team from favorites');
                }

                _updateFavoriteTeams();

              });

              Navigator.pop(context);
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
