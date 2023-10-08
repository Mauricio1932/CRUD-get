import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


import 'features/users/presentation/blocs/user/user_bloc.dart';
import 'features/users/presentation/blocs/users/users_bloc.dart';
import 'features/users/presentation/pages/users_page.dart';
import 'usecase_config.dart';

UsecaseConfig usecaseConfig = UsecaseConfig();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (BuildContext context) => UsersBloc(
            getUsersUsecase: usecaseConfig.getUsersUsecase!,
            deleteUserUsecase: usecaseConfig.deleteUserUsecase!,
          ),
        ),

        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(
            createUserUsecase: usecaseConfig.createUserUsecase!,
            updateUserUsecase: usecaseConfig.updateUserUsecase!,
          ),
        ),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UsersPage(),
      ),
    );
  }
}
