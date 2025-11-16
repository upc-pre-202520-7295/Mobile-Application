import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/betting_insights/domain/entities/value_bet.dart';

abstract class ValueBetsRepository {
  ResultFuture<List<ValueBet>> getValueBets();
  ResultFuture<ValueBet> getValueBetById(int id);
  ResultFuture<List<ValueBet>> getValueBetsByConfidence(String confidence);
}