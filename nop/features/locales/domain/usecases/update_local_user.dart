import '../entities/Local.dart';
import '../repositories/local_repository.dart';

class UpdateLocalUsecase {
  final LocalRepository localRepository;

  UpdateLocalUsecase(this.localRepository);

  Future<String> execute(Local local) async {
    return await localRepository.updateLocal(local);
  }
}