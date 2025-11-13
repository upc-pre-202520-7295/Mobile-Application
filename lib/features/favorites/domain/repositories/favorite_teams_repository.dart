
import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/favorites/domain/entities/favorite_team.dart';

abstract class FavoriteTeamsRepository{
  ResultFuture<List<FavoriteTeam>> getFavoriteTeams();
  ResultFuture<void> addFavoriteTeam(int id);
  ResultFuture<void> deleteFavoriteTeam(int id);
}