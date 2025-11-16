// lib/features/favorite_teams/presentation/providers/favorite_teams_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// Modelo simple para los datos estáticos
class FavoriteTeamData {
  final String id;
  final String name;
  final String league;
  final String initials;
  final Color color;

  FavoriteTeamData({
    required this.id,
    required this.name,
    required this.league,
    required this.initials,
    required this.color,
  });
}

// State para manejar la lista de equipos
class FavoriteTeamsState {
  final List<FavoriteTeamData> teams;
  final bool isLoading;
  final String? error;

  FavoriteTeamsState({
    this.teams = const [],
    this.isLoading = false,
    this.error,
  });

  FavoriteTeamsState copyWith({
    List<FavoriteTeamData>? teams,
    bool? isLoading,
    String? error,
  }) {
    return FavoriteTeamsState(
      teams: teams ?? this.teams,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// StateNotifier para manejar las acciones
class FavoriteTeamsNotifier extends StateNotifier<FavoriteTeamsState> {
  FavoriteTeamsNotifier() : super(FavoriteTeamsState(teams: _staticTeams));

  // Datos estáticos iniciales
  static final List<FavoriteTeamData> _staticTeams = [
    FavoriteTeamData(
      id: '1',
      name: 'Manchester City',
      league: 'Premier League',
      initials: 'MC',
      color: const Color(0xFF6CABDD),
    ),
    FavoriteTeamData(
      id: '2',
      name: 'Liverpool',
      league: 'Premier League',
      initials: 'LIV',
      color: const Color(0xFFE74C3C),
    ),
    FavoriteTeamData(
      id: '3',
      name: 'Bayern Munich',
      league: 'Bundesliga',
      initials: 'BAY',
      color: const Color(0xFFDC2626),
    ),
  ];

  void removeTeam(String teamId) {
    final updatedTeams = state.teams.where((team) => team.id != teamId).toList();
    state = state.copyWith(teams: updatedTeams);
  }

  void addTeam(FavoriteTeamData team) {
    final updatedTeams = [...state.teams, team];
    state = state.copyWith(teams: updatedTeams);
  }

  void loadTeams() {
    // Simular carga (para más adelante cuando conectes con datasources)
    state = state.copyWith(isLoading: true);

    // Simular delay de red
    Future.delayed(const Duration(milliseconds: 500), () {
      state = state.copyWith(
        teams: _staticTeams,
        isLoading: false,
      );
    });
  }
}

// Provider del StateNotifier
final favoriteTeamsProvider =
StateNotifierProvider<FavoriteTeamsNotifier, FavoriteTeamsState>((ref) {
  return FavoriteTeamsNotifier();
});
