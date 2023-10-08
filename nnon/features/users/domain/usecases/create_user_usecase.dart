
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class CreateUserUsecase {
  final UserRepository userRepository;

  CreateUserUsecase(this.userRepository);

  Future<void> execute(User user) async {
    return await userRepository.createUser(user);
  }
}
