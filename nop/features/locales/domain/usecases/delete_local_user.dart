import '../entities/Local.dart';
import '../repositories/local_repository.dart';

class DeleteLocalUsecase {
  final LocalRepository localRepository;

  DeleteLocalUsecase(this.localRepository);

  Future<String> execute(String id) async {
    return await localRepository.deleteLocal(id);
  }
}