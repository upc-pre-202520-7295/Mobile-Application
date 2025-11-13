// lib/features/data_retrieval/presentation/screens/filters_search_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/presentation/widgets/top_bar.dart';
import '../providers/match_provider.dart';
import '../widgets/search_field.dart';
import '../widgets/filter_dropdown.dart';
import '../widgets/match_preview_card.dart';
import 'match_details_screen.dart';

class FiltersSearchScreen extends ConsumerStatefulWidget {
  const FiltersSearchScreen({super.key});

  @override
  ConsumerState<FiltersSearchScreen> createState() => _FiltersSearchScreenState();
}

class _FiltersSearchScreenState extends ConsumerState<FiltersSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedLeague;
  String? _selectedCondition;

  final List<String> _leagues = [
    'All',
    'Premier League',
    'La Liga',
    'Bundesliga',
    'Serie A',
    'Ligue 1',
  ];

  final List<String> _conditions = [
    'All matches',
    'Home wins',
    'Away wins',
    'Draws',
    'High scoring',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = ref.watch(matchesProvider);

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
              // Header
              const Text(
                'Filters & Search',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1F3D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find specific matches and teams using advanced filtering options',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // Filters Card
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Team
                    const Text(
                      'Search Team',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A1F3D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SearchField(
                      controller: _searchController,
                      hintText: 'Enter team name...',
                      onChanged: (value) {
                        ref.read(matchesProvider.notifier).searchByTeam(value);
                      },
                    ),
                    const SizedBox(height: 24),

                    // League Filter
                    const Text(
                      'League',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A1F3D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilterDropdown(
                      value: _selectedLeague,
                      items: _leagues,
                      hint: 'Select a league',
                      onChanged: (value) {
                        setState(() {
                          _selectedLeague = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Match Condition Filter
                    const Text(
                      'Match Condition',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A1F3D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilterDropdown(
                      value: _selectedCondition,
                      items: _conditions,
                      hint: 'Select condition',
                      onChanged: (value) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Apply Filters Button
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ref.read(matchesProvider.notifier).applyFilters();
                              _showSnackBar('Filters applied');
                            },
                            icon: const Icon(Icons.filter_alt, size: 20),
                            label: const Text('Apply Filters'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A1F3D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Clear All Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _selectedLeague = null;
                            _selectedCondition = null;
                          });
                          ref.read(matchesProvider.notifier).clearFilters();
                          _showSnackBar('Filters cleared');
                        },
                        icon: const Icon(Icons.clear, size: 20),
                        label: const Text('Clear All'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                          side: BorderSide(color: Colors.grey[300]!),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Results Section
              if (matchesState.matches.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Results',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A1F3D),
                      ),
                    ),
                    Text(
                      '${matchesState.matches.length} matches',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Matches List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: matchesState.matches.length,
                  itemBuilder: (context, index) {
                    final match = matchesState.matches[index];
                    final league = ref.read(matchesProvider.notifier).getMatchLeague(match);

                    return MatchPreviewCard(
                      match: match,
                      league: league,
                      onTap: () {
                        ref.read(matchesProvider.notifier).selectMatch(match);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MatchDetailsScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],

              // Empty State
              if (matchesState.matches.isEmpty && !matchesState.isLoading) ...[
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No matches found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try adjusting your filters',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Loading State
              if (matchesState.isLoading) ...[
                const SizedBox(height: 40),
                const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF00D9A3),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar is handled by parent
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
