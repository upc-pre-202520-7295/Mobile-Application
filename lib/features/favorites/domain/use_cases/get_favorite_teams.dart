import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/favorites/domain/entities/favorite_team.dart';
import 'package:betalyze_mobile/features/favorites/domain/repositories/favorite_teams_repository.dart';

class GetFavoriteTeamUseCase{
  final FavoriteTeamsRepository repository;

  GetFavoriteTeamUseCase(this.repository);

  ResultFuture<List<FavoriteTeam>> call(){
    return repository.getFavoriteTeams();
  }
}