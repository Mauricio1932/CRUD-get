// import 'package:pluto_grid_crud/features/users/domain/repositories/user_repository.dart';

import '../repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository userRepository;

  DeleteUserUsecase(this.userRepository);

  Future<void> execute(String id) async {
    return await userRepository.deleteUser(id);
  }
}
