// import 'package:pluto_grid_crud/features/users/domain/entities/user.dart';
// import 'package:pluto_grid_crud/features/users/domain/repositories/user_repository.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsersUsecase {
  final UserRepository userRepository;

  GetUsersUsecase(this.userRepository);

  Future<List<User>> execute() async {
    return await userRepository.getUsers();
  }
}
