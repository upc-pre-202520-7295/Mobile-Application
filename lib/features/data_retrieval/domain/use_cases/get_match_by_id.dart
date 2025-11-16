import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/repositories/match_repository.dart';

class GetMatchByIdUseCase{
  final MatchRepository repository;

  GetMatchByIdUseCase(this.repository);

  ResultFuture<MatchGame> call(int id){
    return repository.getMatchById(id);
  }

}