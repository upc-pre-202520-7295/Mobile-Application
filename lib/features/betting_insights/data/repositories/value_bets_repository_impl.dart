
import 'package:betalyze_mobile/features/betting_insights/data/data_sources/value_bets_datasource.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/value_bet.dart';
import '../../domain/repositories/value_bets_repository.dart';

class ValueBetsRepositoryImpl implements ValueBetsRepository {
  final ValueBetsDataSource dataSource;

  ValueBetsRepositoryImpl({required this.dataSource});

  @override
  ResultFuture<List<ValueBet>> getValueBets() async {
    try {
      final result = await dataSource.getValueBets();
      return Right(result);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }



  @override
  ResultFuture<ValueBet> getValueBetById(int id) async {
    try {
      final result = await dataSource.getValueBetById(id);
      return Right(result);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }

  @override
  ResultFuture<List<ValueBet>> getValueBetsByConfidence(String confidence) async {
    try {
      final allBets = await dataSource.getValueBets();
      final filtered = allBets
          .where((bet) => bet.confidenceLevel == confidence)
          .toList();
      return Right(filtered);
    } on ServerFailure{
      return Left(ServerFailure());
    }
  }
}
