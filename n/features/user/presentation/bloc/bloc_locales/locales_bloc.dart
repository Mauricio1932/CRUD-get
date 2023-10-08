import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:localeats/features/locales/domain/usecase/get_single_local.dart';

// import '../../../locales/domain/usecase/get_local_usecases.dart';
import '../../../../locales/domain/usecase/get_local_usecases.dart';
import 'locales_event.dart';
import 'locales_state.dart';

class LocalesBloc extends Bloc<LocalesEvent, LocalesState> {
  final GetLocalUsecase getLocalUsecase;

  LocalesBloc(this.getLocalUsecase) : super(const LocalesState()) {
    on<LocalRequest>(_handleLocalesRecuested);
    // on<LocalSingleView>(_handleViewLocal);
    // on<DeleteLocalSingleView>(_handleCloseViewLocal);
    // on<LocalSingleRequest>(_handleSingleLocalesRecuested);
  }

  Future<void> _handleLocalesRecuested(
    event,
    Emitter<LocalesState> emit,
  ) async {
    try {
      emit(state.copyWith(
        localesStatus: LocalesRequest.requestInProgress,
      ));

      final response = await getLocalUsecase.execute();

      emit(
        state.copyWith(
          localesStatus: LocalesRequest.requestSuccess,
          locales: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        localesStatus: LocalesRequest.requestFailure,
      ));
    }
  }

  
}
