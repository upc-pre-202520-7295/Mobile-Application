import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/repositories/match_repository.dart';

class GetTodayMatches {
  final MatchRepository repository;

  GetTodayMatches(this.repository);

  ResultFuture<List<MatchGame>> call() {
    return repository.getTodayMatches();
  }
}
