import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiUserDatasourceImp apiUserDatasourceImp;

  UserRepositoryImpl({required this.apiUserDatasourceImp});

    @override
  Future<List<User>> getUsers() async {
    return await apiUserDatasourceImp.getUsers();
  }
}