import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';

abstract class MatchRepository {
  ResultFuture<List<MatchGame>> getMatches();
  ResultFuture<List<MatchGame>> getTodayMatches();
}
