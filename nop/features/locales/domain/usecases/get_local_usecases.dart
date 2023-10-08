import '../entities/Local.dart';
import '../repositories/local_repository.dart';

class GetLocalUsecase {
  final LocalRepository localRepository;

  GetLocalUsecase(this.localRepository);

  Future<List<Local>> execute() async {
    return await localRepository.getLocals();
  }
}