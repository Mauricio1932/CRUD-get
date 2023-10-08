import 'package:bloc_use/user/domain/entities/user.dart';

enum UserRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure
}

class UserState {
  const UserState({
    this.users = const [],
    this.usersStatus = UserRequest.unknown,
    this.userId = const {},
  });

  final List<User> users;
  final UserRequest usersStatus;
  final Set<int> userId;

  UserState copyWith({
    List<User>? users,
    UserState? userState,
    Set<int>? userId,
    required usersStatus,
  }) =>
      UserState(
        users: users ?? this.users,
        usersStatus: usersStatus ?? this.usersStatus,
        userId: userId ?? this.userId,
      );
}
