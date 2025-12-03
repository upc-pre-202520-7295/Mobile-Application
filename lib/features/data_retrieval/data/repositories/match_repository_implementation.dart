import 'package:betalyze_mobile/core/errors/failures.dart';
import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/data_retrieval/data/data_sources/match_data_source.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/repositories/match_repository.dart';
import 'package:dartz/dartz.dart';

class MatchRepositoryImpl implements MatchRepository{

  final MatchDataSource matchDataSource;

  MatchRepositoryImpl({required this.matchDataSource});

  @override
  ResultFuture<List<MatchGame>> getMatches() async {
    try {
      final response = await matchDataSource.getMatches();
      return Right(response);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<List<MatchGame>> getTodayMatches() async {
    try {
      final response = await matchDataSource.getTodayMatches();
      return Right(response);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

}
