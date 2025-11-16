import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_details.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/repositories/match_repository.dart';

class GetMatchDetailsByMatchGameId {
  final MatchRepository repository;

  GetMatchDetailsByMatchGameId(this.repository);

  ResultFuture<MatchDetails> call(int matchGameId) {
    return repository.getMatchDetailsByMatchGameId(matchGameId);
  }
}