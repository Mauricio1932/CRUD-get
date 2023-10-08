import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/getusers_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUsecase userUsecase;

  UserBloc(this.userUsecase) : super(const UserState()) {
    on<GetUserRequest>(_handleLocalesRecuested);
    on<ViewUser>(_handleviewuser);
    on<RemoveViewUser>(_handleRemoveuser);
  }

  Future<void> _handleLocalesRecuested(
    event,
    Emitter<UserState> emit,
  ) async {
    print("se esta ejevutando bloc");
    try {
      emit(state.copyWith(
        usersStatus: UserRequest.requestInProgress,
      ));

      // final response = await UserUsecase.execute(event.user);
      final response = await userUsecase.execute();

      emit(
        state.copyWith(
          usersStatus: UserRequest.requestSuccess,
          users: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        usersStatus: UserRequest.requestFailure,
      ));
    }
  }

  Future<void> _handleviewuser(
    event,
    Emitter<UserState> emit,
  ) async {
    print("id ${event.userId}");
    emit(
      state.copyWith(
        userId: {event.userId},
        usersStatus: null,
      ),
    );
  }

  Future<void> _handleRemoveuser(
    event,
    Emitter<UserState> emit,
  ) async {
    emit(
      state.copyWith(
        userId: {...state.userId}..remove(event.userId), // Corregir aquí
        usersStatus: null,
      ),
    );
  }
}
