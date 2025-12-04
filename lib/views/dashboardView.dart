import 'package:betalyze_mobile/domain/Match.dart';
import 'package:betalyze_mobile/views/widgets/match_card.dart';
import 'package:betalyze_mobile/views/widgets/top_bar.dart';
import 'package:flutter/material.dart';

import '../services/matchClient.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<MatchGame> _matches = [];
  MatchClient client = MatchClient();
  TextEditingController _leagueController = TextEditingController();

  void _updateMatches() {
    client.getPredictions().then((value) {
      setState(() {
        _matches = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: TopBar(
        title: 'Betalyze',
        onNotificationTap: () => _showSnackBar(context, 'Notifications'),
        onSettingsTap: () => _showSnackBar(context, 'Settings'),
        onProfileTap: () => _showSnackBar(context, 'Profile'),
      ),

      body: RefreshIndicator(
        onRefresh: () async => _updateMatches(),
        color: const Color(0xFF00D9A3),
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Matches',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A1F3D),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filters
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SizedBox(
                  child: TextField(
                    controller: _leagueController,
                    decoration: const InputDecoration(
                      hintText: 'Search for a team',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onChanged: (value) {
                      // debouncer
                      setState(() {
                        _leagueController.text = value;
                      });
                    },
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (_matches.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'No matches found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    );
                  }
                  return MatchCard(match: _matches[index]);
                }, childCount: _matches.isEmpty ? 1 : _matches.length),
              ),
            ),
          ],
        ),
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
