// import '../entities/user.dart';
import '../repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository userRepository;

  DeleteUserUsecase(this.userRepository);

  Future<void> execute(String id) async {
    return await userRepository.deleteUser(id);
  }
}
