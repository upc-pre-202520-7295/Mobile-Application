import 'package:betalyze_mobile/core/errors/failures.dart';
import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/favorites/data/data_sources/favorite_teams_remote_data_source.dart';
import 'package:betalyze_mobile/features/favorites/domain/entities/favorite_team.dart';
import 'package:betalyze_mobile/features/favorites/domain/repositories/favorite_teams_repository.dart';
import 'package:dartz/dartz.dart';

class FavoriteTeamsRepositoryImpl implements FavoriteTeamsRepository {

  final FavoriteTeamsRemoteDataSource favoriteTeamsRemoteDataSource;

  FavoriteTeamsRepositoryImpl({required this.favoriteTeamsRemoteDataSource});

  @override
  ResultFuture<void> addFavoriteTeam(int id) async{
    try {
      final response = await favoriteTeamsRemoteDataSource.addFavoriteTeam(id);
      return Right(response);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<void> deleteFavoriteTeam(int id) async{
    try {
      await favoriteTeamsRemoteDataSource.deleteFavoriteTeam(id);
      return Right(null);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<List<FavoriteTeam>> getFavoriteTeams() async{
    try{
      final List<FavoriteTeam> response = await favoriteTeamsRemoteDataSource.getFavoriteTeams();
      return Right(response);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }

}