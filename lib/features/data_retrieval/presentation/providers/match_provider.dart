// lib/features/data_retrieval/presentation/providers/match_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/match_details.dart';
import '../../domain/entities/match_game.dart';
import '../../../favorites/domain/entities/team.dart';

// Estado para la lista de matches
class MatchesState {
  final List<MatchGame> matches;
  final MatchGame? selectedMatch;
  final bool isLoading;
  final String? error;
  final String? searchQuery;
  final String? selectedLeague;
  final String? selectedCondition;

  MatchesState({
    this.matches = const [],
    this.selectedMatch,
    this.isLoading = false,
    this.error,
    this.searchQuery,
    this.selectedLeague,
    this.selectedCondition,
  });

  MatchesState copyWith({
    List<MatchGame>? matches,
    MatchGame? selectedMatch,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? selectedLeague,
    String? selectedCondition,
  }) {
    return MatchesState(
      matches: matches ?? this.matches,
      selectedMatch: selectedMatch ?? this.selectedMatch,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedLeague: selectedLeague ?? this.selectedLeague,
      selectedCondition: selectedCondition ?? this.selectedCondition,
    );
  }
}

// StateNotifier con datos estáticos
class MatchesNotifier extends StateNotifier<MatchesState> {
  MatchesNotifier() : super(MatchesState(matches: _staticMatches));

  // Datos estáticos (luego se reemplazan con API)
  static final List<MatchGame> _staticMatches = [
    MatchGame(
      id: 1,
      homeTeam: const Team(
        id: 1,
        fullname: 'Manchester City',
      ),
      awayTeam: const Team(
        id: 2,
        fullname: 'Liverpool',
      ),
      startTime: DateTime(2025, 10, 8, 15, 0),
      matchDetails: const MatchDetails(
        id: 1,
        matchWinner: 1,
        homeScore: 2,
        awayScore: 1,
      ),
    ),
    MatchGame(
      id: 2,
      homeTeam: const Team(
        id: 3,
        fullname: 'Bayern Munich',
      ),
      awayTeam: const Team(
        id: 4,
        fullname: 'Borussia Dortmund',
      ),
      startTime: DateTime(2025, 10, 9, 18, 30),
      matchDetails: const MatchDetails(
        id: 2,
        matchWinner: 0,
        homeScore: 3,
        awayScore: 3,
      ),
    ),
    MatchGame(
      id: 3,
      homeTeam: const Team(
        id: 5,
        fullname: 'Real Madrid',
      ),
      awayTeam: const Team(
        id: 6,
        fullname: 'Barcelona',
      ),
      startTime: DateTime(2025, 10, 10, 20, 0),
      matchDetails: const MatchDetails(
        id: 3,
        matchWinner: 2,
        homeScore: 1,
        awayScore: 2,
      ),
    ),
    MatchGame(
      id: 4,
      homeTeam: const Team(
        id: 7,
        fullname: 'Paris Saint-Germain',
      ),
      awayTeam: const Team(
        id: 8,
        fullname: 'Olympique Marseille',
      ),
      startTime: DateTime(2025, 10, 11, 19, 0),
      matchDetails: const MatchDetails(
        id: 4,
        matchWinner: 1,
        homeScore: 3,
        awayScore: 0,
      ),
    ),
    MatchGame(
      id: 5,
      homeTeam: const Team(
        id: 9,
        fullname: 'Inter Milan',
      ),
      awayTeam: const Team(
        id: 10,
        fullname: 'AC Milan',
      ),
      startTime: DateTime(2025, 10, 12, 18, 0),
      matchDetails: const MatchDetails(
        id: 5,
        matchWinner: 1,
        homeScore: 2,
        awayScore: 1,
      ),
    ),
  ];

  // Mapa estático de ligas por equipo (ya que Team no tiene league)
  static final Map<int, String> _teamLeagues = {
    1: 'Premier League', // Manchester City
    2: 'Premier League', // Liverpool
    3: 'Bundesliga',     // Bayern Munich
    4: 'Bundesliga',     // Borussia Dortmund
    5: 'La Liga',        // Real Madrid
    6: 'La Liga',        // Barcelona
    7: 'Ligue 1',        // PSG
    8: 'Ligue 1',        // Marseille
    9: 'Serie A',        // Inter Milan
    10: 'Serie A',       // AC Milan
  };

  String _getLeagueForTeam(int teamId) {
    return _teamLeagues[teamId] ?? 'Unknown';
  }

  // Cargar matches (simulado)
  Future<void> loadMatches() async {
    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 800));

    state = state.copyWith(
      matches: _staticMatches,
      isLoading: false,
    );
  }

  // Seleccionar un match
  void selectMatch(MatchGame match) {
    state = state.copyWith(selectedMatch: match);
  }

  // Buscar por equipo
  void searchByTeam(String query) {
    state = state.copyWith(searchQuery: query);

    if (query.isEmpty) {
      state = state.copyWith(matches: _staticMatches);
      return;
    }

    final filtered = _staticMatches.where((match) {
      final homeTeam = match.homeTeam.fullname.toLowerCase();
      final awayTeam = match.awayTeam.fullname.toLowerCase();
      final searchLower = query.toLowerCase();
      return homeTeam.contains(searchLower) || awayTeam.contains(searchLower);
    }).toList();

    state = state.copyWith(matches: filtered);
  }

  // Filtrar por liga
  void filterByLeague(String? league) {
    state = state.copyWith(selectedLeague: league);

    if (league == null || league.isEmpty || league == 'All') {
      state = state.copyWith(matches: _staticMatches);
      return;
    }

    final filtered = _staticMatches.where((match) {
      final homeTeamLeague = _getLeagueForTeam(match.homeTeam.id);
      return homeTeamLeague == league;
    }).toList();

    state = state.copyWith(matches: filtered);
  }

  // Aplicar filtros combinados
  void applyFilters() {
    var filtered = _staticMatches;

    // Filtrar por búsqueda
    if (state.searchQuery != null && state.searchQuery!.isNotEmpty) {
      final query = state.searchQuery!.toLowerCase();
      filtered = filtered.where((match) {
        return match.homeTeam.fullname.toLowerCase().contains(query) ||
            match.awayTeam.fullname.toLowerCase().contains(query);
      }).toList();
    }

    // Filtrar por liga
    if (state.selectedLeague != null &&
        state.selectedLeague!.isNotEmpty &&
        state.selectedLeague != 'All') {
      filtered = filtered.where((match) {
        final homeTeamLeague = _getLeagueForTeam(match.homeTeam.id);
        return homeTeamLeague == state.selectedLeague;
      }).toList();
    }

    state = state.copyWith(matches: filtered);
  }

  // Limpiar filtros
  void clearFilters() {
    state = MatchesState(matches: _staticMatches);
  }

  // Helper para obtener la liga de un match
  String getMatchLeague(MatchGame match) {
    return _getLeagueForTeam(match.homeTeam.id);
  }
}

// Provider del StateNotifier
final matchesProvider =
StateNotifierProvider<MatchesNotifier, MatchesState>((ref) {
  return MatchesNotifier();
});
