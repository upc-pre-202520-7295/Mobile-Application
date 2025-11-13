import 'package:betalyze_mobile/core/utils/typedefs.dart';
import 'package:betalyze_mobile/features/betting_insights/domain/entities/value_bet.dart';
import 'package:betalyze_mobile/features/betting_insights/domain/repositories/value_bets_repository.dart';

class GetValueBets {
  final ValueBetsRepository repository;

  GetValueBets(this.repository);

  ResultFuture<List<ValueBet>> call() {
    return repository.getValueBets();
  }
}