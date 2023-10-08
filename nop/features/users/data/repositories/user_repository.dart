import '../datasources/users_data_source.dart';
import '../../domain/entities/User.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<String> createUser(User user) async {
    return await userDataSource.createUser(user);
  }

  @override
  Future<String> loginUser(User user) async {
   User loggedInUser = await userDataSource.login(user);
  
  if (loggedInUser !=null) {
    // El inicio de sesión fue exitoso
    return 'User logged in successfully';
  } else {
    // El inicio de sesión falló
    return 'Failed to log in';
  }
}
}
