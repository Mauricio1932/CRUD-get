import '../entities/Local.dart';
import '../repositories/local_repository.dart';

class CreateLocalUsecase {
  final LocalRepository localRepository;

  CreateLocalUsecase(this.localRepository);

  Future<String> execute(Local local) async {
    return await localRepository.createLocal(local);
  }
}