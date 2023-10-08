import 'package:bloc_use/features/locales/data/datasources/local_data_source.dart';
import 'package:bloc_use/features/locales/data/repositories/local_repository_impl.dart';
import 'package:bloc_use/features/locales/domain/usecases/get_local_usecases.dart';
// import 'package:bloc_use/features/users/data/datasources/users_data_source.dart';
//import 'package:bloc_use/features/users/data/repositories/user_repository.dart';
// import 'package:bloc_use/features/users/domain/usecases/create_user_usecase.dart';

// import 'package:bloc_use/features/users/domain/usecases/login_user_usecase.dart';

class UsecaseConfig {
  /*ApiUserDataSource? apiUserDataSource;
  UserRepositoryImpl? userRepositoryImpl;
  LoginUserUsecase? loginUserUsecase;
  CreateUserUsecase? createUserUsecase;*/

  ApiUserLocalDataSource? apiUserLocalDataSource;
  UserRepositoryImpl? userRepositoryImpl2;
  GetLocalUsecase? getLocalUsecase;

  UsecaseConfig() {
    /*apiUserDataSource = ApiUserDataSource(apiUrl: '');
    userRepositoryImpl = UserRepositoryImpl(userDataSource: apiUserDataSource!);
    loginUserUsecase = LoginUserUsecase(userRepositoryImpl!);
    createUserUsecase = CreateUserUsecase(userRepositoryImpl!);*/

    apiUserLocalDataSource = ApiUserLocalDataSource();
    userRepositoryImpl2 =
        UserRepositoryImpl(userLocalDataSource: apiUserLocalDataSource!);
    getLocalUsecase = GetLocalUsecase(userRepositoryImpl2!);
    getLocalUsecase = GetLocalUsecase(userRepositoryImpl2!);
  }
}
