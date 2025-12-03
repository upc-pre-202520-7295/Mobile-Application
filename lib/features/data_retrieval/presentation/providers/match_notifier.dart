import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/use_cases/get_matches.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/use_cases/get_today_matches.dart';
import 'package:betalyze_mobile/features/data_retrieval/presentation/providers/match_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchesNotifier extends StateNotifier<MatchesState> {
  final GetMatches getMatches;
  final GetTodayMatches getTodayMatches;

  MatchesNotifier({
    required this.getMatches,
    required this.getTodayMatches,
  }) : super(MatchesState());

  Future<void> loadMatches() async {
    state = state.copyWith(isLoading: true);

    final result = await getMatches();

    result.fold(
          (failure) => state = state.copyWith(error: failure.message, isLoading: false),
          (matches) => state = state.copyWith(matches: matches, isLoading: false),
    );
  }

  Future<void> loadTodayMatches() async {
    state = state.copyWith(isLoading: true);

    final result = await getTodayMatches();

    result.fold(
          (failure) => state = state.copyWith(error: failure.message, isLoading: false),
          (matches) => state = state.copyWith(matches: matches, isLoading: false),
    );
  }

  void selectMatch(MatchGame match) {
    state = state.copyWith(selectedMatch: match);
  }

  void clearSelectedMatch() {
    state = state.copyWith(selectedMatch: null);
  }

  void filterMatchesByCondition(String condition) {
    state = state.copyWith(selectedCondition: condition);
  }

  Future<void> searchMatches(String query) async {
    state = state.copyWith(isLoading: true);

    final result = await getMatches();
    final condition = state.selectedCondition;
    final league = state.selectedLeague;

    if (result.isRight()) {
      final matches = result.fold((failure) => List<MatchGame>.empty(), (matches) => matches);
      final filtered = matches.where((match) {
        if (league != null && league.isNotEmpty) {
          return match.league == league;
        }

        if (condition != null && condition.isNotEmpty) {
          if(condition == 'home') {
            return match.homeScore > match.awayScore;
          } else if(condition == 'away') {
            return match.awayScore > match.homeScore;
          } else {
            return match.homeScore == match.awayScore;
          }
        }

        return true;
      }).toList();

      state = state.copyWith(matches: filtered, isLoading: false);
    } else {
      state = state.copyWith(error: result.fold((failure) => failure.message, (_) => ''), matches: [], isLoading: false);
    }
  }
}
