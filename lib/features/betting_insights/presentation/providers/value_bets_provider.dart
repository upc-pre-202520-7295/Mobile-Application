// lib/features/betting_insights/presentation/providers/value_bets_provider.dart

import 'package:betalyze_mobile/features/betting_insights/data/data_sources/value_bets_datasource.dart';
import 'package:betalyze_mobile/features/betting_insights/domain/use_cases/get_value_bets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/value_bets_repository_impl.dart';
import '../../domain/entities/value_bet.dart';

// State
class ValueBetsState {
  final List<ValueBet> valueBets;
  final bool isLoading;
  final String? error;
  final String? selectedConfidence;

  ValueBetsState({
    this.valueBets = const [],
    this.isLoading = false,
    this.error,
    this.selectedConfidence,
  });

  ValueBetsState copyWith({
    List<ValueBet>? valueBets,
    bool? isLoading,
    String? error,
    String? selectedConfidence,
  }) {
    return ValueBetsState(
      valueBets: valueBets ?? this.valueBets,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedConfidence: selectedConfidence ?? this.selectedConfidence,
    );
  }
}

// Notifier
class ValueBetsNotifier extends StateNotifier<ValueBetsState> {
  final GetValueBets getValueBetsUseCase;

  ValueBetsNotifier({required this.getValueBetsUseCase})
      : super(ValueBetsState());

  Future<void> loadValueBets() async {
    state = state.copyWith(isLoading: true);

    final result = await getValueBetsUseCase();

    result.fold(
          (failure) => state = state.copyWith(
        error: failure.message,
        isLoading: false,
      ),
          (bets) => state = state.copyWith(
        valueBets: bets,
        isLoading: false,
      ),
    );
  }

  void filterByConfidence(String? confidence) {
    state = state.copyWith(selectedConfidence: confidence);
  }

  List<ValueBet> get filteredBets {
    if (state.selectedConfidence == null || state.selectedConfidence == 'ALL') {
      return state.valueBets;
    }
    return state.valueBets
        .where((bet) => bet.confidenceLevel == state.selectedConfidence)
        .toList();
  }
}

// Provider dependencies
final valueBetsDataSourceProvider = Provider<ValueBetsDataSource>((ref) {
  return ValueBetsDataSourceImpl();
});

final valueBetsRepositoryProvider = Provider((ref) {
  return ValueBetsRepositoryImpl(
    dataSource: ref.read(valueBetsDataSourceProvider),
  );
});

final getValueBetsUseCaseProvider = Provider((ref) {
  return GetValueBets(ref.read(valueBetsRepositoryProvider));
});

final valueBetsProvider =
StateNotifierProvider<ValueBetsNotifier, ValueBetsState>((ref) {
  return ValueBetsNotifier(
    getValueBetsUseCase: ref.read(getValueBetsUseCaseProvider),
  );
});
