import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/favorites/domain/entities/favorite_team.dart';
import 'package:betalyze_mobile/features/favorites/domain/repositories/favorite_teams_repository.dart';

class AddFavoriteTeamUseCase{
  final FavoriteTeamsRepository repository;

  AddFavoriteTeamUseCase(this.repository);

  ResultFuture<void> call(int id){
    return repository.addFavoriteTeam(id);
  }
}