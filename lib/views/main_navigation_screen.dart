import 'package:betalyze_mobile/views/dashboardView.dart';
import 'package:betalyze_mobile/views/favoritesView.dart';
import 'package:betalyze_mobile/views/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Provider para manejar el índice de navegación
final navigationIndexProvider = StateProvider<int>((ref) => 0);

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const DashboardView(),
          const FavoritesView()
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
}
