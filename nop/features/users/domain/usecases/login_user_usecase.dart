import '../entities/User.dart';
import '../repositories/user_repository.dart';

class LoginUserUsecase {
  final UserRepository userRepository;

  LoginUserUsecase(this.userRepository);

  Future<String> execute(User user) async {
    return await userRepository.loginUser(user);
  }
}