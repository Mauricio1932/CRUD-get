import '../entities/User.dart';

abstract class UserRepository {
  Future<String> loginUser(User user);
  Future<String> createUser(User user);
}