import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/favorites/domain/repositories/favorite_teams_repository.dart';

class DeleteFavoriteTeamUseCase{
  final FavoriteTeamsRepository repository;

  DeleteFavoriteTeamUseCase(this.repository);

  ResultFuture<void> call(int id){
    return repository.deleteFavoriteTeam(id);
  }
}