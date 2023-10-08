import '../entities/User.dart';
import '../repositories/user_repository.dart';

class CreateUserUsecase {
  final UserRepository userRepository;

  CreateUserUsecase(this.userRepository);

  Future<String> execute(User user) async {
    return await userRepository.createUser(user);
  }
}