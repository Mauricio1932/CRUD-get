


import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsersUsecase {
  final UserRepository userRepository;

  GetUsersUsecase(this.userRepository);

  Future<List<User>> execute() async {
    return await userRepository.getUsers();
  }
}
