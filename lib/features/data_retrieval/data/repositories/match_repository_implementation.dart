import 'package:betalyze_mobile/core/errors/failures.dart';
import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/data_retrieval/data/data_sources/match_data_source.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_details.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/entities/match_game.dart';
import 'package:betalyze_mobile/features/data_retrieval/domain/repositories/match_repository.dart';
import 'package:dartz/dartz.dart';

class MatchRepositoryImpl implements MatchRepository{

  final MatchDataSource matchDataSource;

  MatchRepositoryImpl({required this.matchDataSource});

  @override
  ResultFuture<MatchGame> getMatchById(int id) async{
    try {
      final response = await matchDataSource.getMatchById(id);
      return Right(response);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<MatchGame> getMatchByTeamName(String teamName) async{
    try {
      final response = await matchDataSource.getMatchByTeamName(teamName);
      return Right(response);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<MatchDetails> getMatchDetailsByMatchGameId(int matchGameId) async {
    try {
      final response = await matchDataSource.getMatchDetailsByMatchGameId(matchGameId);
      return Right(response);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<List<MatchGame>> getMatches() async {
    try {
      final response = await matchDataSource.getMatches();
      return Right(response);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

}