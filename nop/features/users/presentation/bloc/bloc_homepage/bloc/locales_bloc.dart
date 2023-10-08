import 'package:bloc_use/features/locales/domain/usecases/get_local_usecases.dart';
import 'package:bloc_use/features/users/presentation/bloc/bloc_homepage/bloc/locales_event.dart';
import 'package:bloc_use/features/users/presentation/bloc/bloc_homepage/bloc/locales_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../locales/domain/repositories/locales_respository.dart';

class LocalesBloc extends Bloc<LocalesEvent, LocalesState> {
  final GetLocalUsecase getLocalUsecase;

  LocalesBloc(this.getLocalUsecase) : super(const LocalesState()) {
    on<LocalRequest>(_handleLocalesRecuested);
    on<LocalView>(_handleViewLocal);
  }

  final LocalesRepository api = LocalesRepository();

  Future<void> _handleLocalesRecuested(
    LocalRequest event,
    Emitter<LocalesState> emit,
  ) async {
    try {
      emit(state.copyWith(
        localesStatus: LocalesRequest.requestInProgress,
      ));

      final response = await api.getProducts();

      emit(state.copyWith(
        localesStatus: LocalesRequest.requestSuccess,
        locales: response,
      ));

    } catch (e) {
      emit(state.copyWith(
        localesStatus: LocalesRequest.requestFailure,
      ));

    }
  }

  Future<void> _handleViewLocal(
    LocalView event,
    Emitter<LocalesState> emit,
  ) async {
    emit(state.copyWith(localId: {...state.localId, event.localId}, localesStatus: null));
  }
}
