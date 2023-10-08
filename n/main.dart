import 'package:bloc_use/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'features/locales/presentation/bloc/bloc_locales/locales_bloc.dart';
import 'features/user/presentation/bloc/bloc_locales/locales_bloc.dart';
import 'usecase_locales_config.dart';

// import 'usecase_config.dart';

UsecaseLocalesConfig usecaseConfig = UsecaseLocalesConfig();


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LocalesBloc(usecaseConfig.getLocalUsecase!)
        ),
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash(
        ),
      ),
    );
  }
}
