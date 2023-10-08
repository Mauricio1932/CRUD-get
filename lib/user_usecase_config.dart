import 'user/data/datasource/user_datasource.dart';
import 'user/data/repositories/user_repository_impl.dart';
import 'user/domain/usecase/getusers_usecase.dart';

class UseCaseUserConfig {
  ApiUserDatasourceImp? apiUserDatasourceImp;
  UserRepositoryImpl? userRepositoryImpl;

  
  UserUsecase? userUsecase;

  UseCaseUserConfig() {
    apiUserDatasourceImp = ApiUserDatasourceImp();
    userRepositoryImpl = UserRepositoryImpl(apiUserDatasourceImp: apiUserDatasourceImp!);

    userUsecase = UserUsecase(userRepositoryImpl!);
    
  }
}