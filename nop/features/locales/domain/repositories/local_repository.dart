import '../entities/Local.dart';

abstract class LocalRepository {
  Future<List<Local>> getLocals();
  Future<String> createLocal(Local local);
  Future<String> updateLocal(Local local);
  Future<String> deleteLocal(String id);
}