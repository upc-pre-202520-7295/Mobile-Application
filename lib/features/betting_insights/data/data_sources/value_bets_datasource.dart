
import 'package:betalyze_mobile/features/betting_insights/data/models/value_bet_model.dart';

abstract class ValueBetsDataSource {
  Future<List<ValueBetModel>> getValueBets();
  Future<ValueBetModel> getValueBetById(int id);
}

class ValueBetsDataSourceImpl implements ValueBetsDataSource {
  // Datos estáticos - se reemplazarán con API calls
  static final List<ValueBetModel> _staticData = [
    ValueBetModel(
      id: 1,
      matchId: 1,
      homeTeam: 'Manchester City',
      awayTeam: 'Liverpool',
      league: 'Premier League',
      matchDate: DateTime(2025, 10, 8),
      outcome: 'Home Win',
      ourProbability: 48.5,
      bookmakerOdds: 2.35,
      impliedProbability: 42.6,
      valuePercentage: 13.8,
      confidenceLevel: 'HIGH',
    ),
    ValueBetModel(
      id: 2,
      matchId: 2,
      homeTeam: 'Bayern Munich',
      awayTeam: 'Borussia Dortmund',
      league: 'Bundesliga',
      matchDate: DateTime(2025, 10, 9),
      outcome: 'Over 2.5',
      ourProbability: 65.2,
      bookmakerOdds: 1.75,
      impliedProbability: 57.1,
      valuePercentage: 8.1,
      confidenceLevel: 'MEDIUM',
    ),
    ValueBetModel(
      id: 3,
      matchId: 3,
      homeTeam: 'Real Madrid',
      awayTeam: 'Barcelona',
      league: 'La Liga',
      matchDate: DateTime(2025, 10, 10),
      outcome: 'Away Win',
      ourProbability: 42.3,
      bookmakerOdds: 2.80,
      impliedProbability: 35.7,
      valuePercentage: 18.5,
      confidenceLevel: 'HIGH',
    ),
    ValueBetModel(
      id: 4,
      matchId: 4,
      homeTeam: 'PSG',
      awayTeam: 'Marseille',
      league: 'Ligue 1',
      matchDate: DateTime(2025, 10, 11),
      outcome: 'BTTS',
      ourProbability: 68.4,
      bookmakerOdds: 1.68,
      impliedProbability: 59.5,
      valuePercentage: 8.9,
      confidenceLevel: 'MEDIUM',
    ),
    ValueBetModel(
      id: 5,
      matchId: 5,
      homeTeam: 'Inter Milan',
      awayTeam: 'AC Milan',
      league: 'Serie A',
      matchDate: DateTime(2025, 10, 12),
      outcome: 'Draw',
      ourProbability: 32.1,
      bookmakerOdds: 3.40,
      impliedProbability: 29.4,
      valuePercentage: 2.7,
      confidenceLevel: 'LOW',
    ),
  ];

  @override
  Future<List<ValueBetModel>> getValueBets() async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));
    return _staticData;
  }

  @override
  Future<ValueBetModel> getValueBetById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _staticData.firstWhere((bet) => bet.id == id);
  }
}