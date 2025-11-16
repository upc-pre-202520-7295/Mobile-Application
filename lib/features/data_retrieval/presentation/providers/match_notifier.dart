import 'package:betalyze_mobile/features/data_retrieval/domain/use_cases/get_matches.dart';
import 'package:betalyze_mobile/features/data_retrieval/presentation/providers/match_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchesNotifier extends StateNotifier<MatchesState> {
  final GetMatches getMatches;
  //final GetMatchById getMatchById;

  MatchesNotifier({
    required this.getMatches,
   // required this.getMatchById,
  }) : super(MatchesState());

  Future<void> loadMatches() async {
    state = state.copyWith(isLoading: true);

    final result = await getMatches();

    result.fold(
          (failure) => state = state.copyWith(error: failure.message, isLoading: false),
          (matches) => state = state.copyWith(matches: matches, isLoading: false),
    );
  }
}
