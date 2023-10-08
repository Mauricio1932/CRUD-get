import '../datasources/local_data_source.dart';
import '../../domain/entities/Local.dart';
import '../../domain/repositories/local_repository.dart';

class UserRepositoryImpl implements LocalRepository {
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl({required this.userLocalDataSource});

  @override
  Future<List<Local>> getLocals() async {
    return await userLocalDataSource.getLocals();
  }

  @override
  Future<String> createLocal(Local local) async {
    return await userLocalDataSource.createLocal(local);
  }

  @override
  Future<String> updateLocal(Local local) async {
    return await userLocalDataSource.updateLocal(local);
  }

  @override
  Future<String> deleteLocal(String id) async {
    return await userLocalDataSource.deleteLocal(id);
  }
}