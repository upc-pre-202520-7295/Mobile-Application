// lib/features/data_retrieval/presentation/providers/match_provider.dart

import 'package:betalyze_mobile/features/data_retrieval/data/data_sources/match_data_source.dart';
import 'package:betalyze_mobile/features/data_retrieval/data/repositories/match_repository_implementation.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/repositories/match_repository.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/use_cases/get_matches.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/use_cases/get_today_matches.dart';
import 'package:betalyze_mobile/features/data_retrieval/presentation/providers/match_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/match_game.dart';

// Estado para la lista de matches
class MatchesState {
  final List<MatchGame> matches;
  final MatchGame? selectedMatch;
  final bool isLoading;
  final String? error;
  final String? searchQuery;
  final String? selectedLeague;
  final String? selectedCondition;

  MatchesState({
    this.matches = const [],
    this.selectedMatch,
    this.isLoading = false,
    this.error,
    this.searchQuery,
    this.selectedLeague,
    this.selectedCondition,
  });

  MatchesState copyWith({
    List<MatchGame>? matches,
    MatchGame? selectedMatch,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? selectedLeague,
    String? selectedCondition,
  }) {
    return MatchesState(
      matches: matches ?? this.matches,
      selectedMatch: selectedMatch ?? this.selectedMatch,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedLeague: selectedLeague ?? this.selectedLeague,
      selectedCondition: selectedCondition ?? this.selectedCondition,
    );
  }
}

final matchSourceProvider = Provider<MatchDataSource>((ref) => MatchDataSourceImpl());
final matchRepositoryProvider = Provider<MatchRepository>((ref) => MatchRepositoryImpl(matchDataSource: ref.read(matchSourceProvider)));
final getMatchesProvider = Provider<GetMatches>((ref) => GetMatches(ref.read(matchRepositoryProvider)));
final getTodayMatchesProvider = Provider<GetTodayMatches>((ref) => GetTodayMatches(ref.read(matchRepositoryProvider)));

// Provider del StateNotifier
final matchesProvider =
StateNotifierProvider<MatchesNotifier, MatchesState>((ref) {
  return MatchesNotifier(
    getMatches: ref.read(getMatchesProvider),
    getTodayMatches: ref.read(getTodayMatchesProvider),
  );
});
