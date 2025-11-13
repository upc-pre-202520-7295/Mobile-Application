import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/repositories/match_repository.dart';

class GetMatchByTeamNameUseCase {
  final MatchRepository repository;

  GetMatchByTeamNameUseCase(this.repository);

  ResultFuture<MatchGame> call(String teamName) {
    return repository.getMatchByTeamName(teamName);
  }
}