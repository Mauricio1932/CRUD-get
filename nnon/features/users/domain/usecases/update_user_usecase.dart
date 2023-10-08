


import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUserUsecase {
  final UserRepository userRepository;

  UpdateUserUsecase(this.userRepository);

  Future<void> execute(User user) async {
    return await userRepository.updateUser(user);
  }
}
