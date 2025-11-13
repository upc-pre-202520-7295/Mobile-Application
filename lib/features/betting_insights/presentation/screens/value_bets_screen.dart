// lib/features/betting_insights/presentation/screens/value_bets_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/presentation/widgets/top_bar.dart';
import '../providers/value_bets_provider.dart';
import '../widgets/value_bet_card.dart';

class ValueBetsScreen extends ConsumerStatefulWidget {
  const ValueBetsScreen({super.key});

  @override
  ConsumerState<ValueBetsScreen> createState() => _ValueBetsScreenState();
}

class _ValueBetsScreenState extends ConsumerState<ValueBetsScreen> {
  String? _selectedFilter = 'ALL';

  final List<String> _filters = ['ALL', 'HIGH', 'MEDIUM', 'LOW'];

  @override
  void initState() {
    super.initState();
    // Cargar value bets al iniciar
    Future.microtask(() {
      ref.read(valueBetsProvider.notifier).loadValueBets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(valueBetsProvider);
    final notifier = ref.read(valueBetsProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: TopBar(
        title: 'Betalyze',
        onNotificationTap: () => _showSnackBar('Notifications'),
        onSettingsTap: () => _showSnackBar('Settings'),
        onProfileTap: () => _showSnackBar('Profile'),
      ),

      body: RefreshIndicator(
        onRefresh: () => notifier.loadValueBets(),
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
                      'Value Bets',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A1F3D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Opportunities where our ML model identifies higher probability than bookmaker odds suggest',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filters
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                            notifier.filterByConfidence(filter);
                          },
                          selectedColor: const Color(0xFF00D9A3),
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? const Color(0xFF00D9A3)
                                : Colors.grey[300]!,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Loading State
            if (state.isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF00D9A3),
                  ),
                ),
              ),

            // Error State
            if (state.error != null && !state.isLoading)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading value bets',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.error!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => notifier.loadValueBets(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),

            // Value Bets List
            if (!state.isLoading && state.error == null)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final bets = notifier.filteredBets;
                      if (bets.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Text(
                              'No value bets found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }
                      return ValueBetCard(valueBet: bets[index]);
                    },
                    childCount: notifier.filteredBets.isEmpty
                        ? 1
                        : notifier.filteredBets.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
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
