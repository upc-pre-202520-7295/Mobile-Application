import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/repositories/match_repository.dart';

class GetMatches {
  final MatchRepository repository;

  GetMatches(this.repository);

  ResultFuture<List<MatchGame>> call() {
    return repository.getMatches();
  }
}