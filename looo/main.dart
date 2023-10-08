import 'package:bloc_use/data/datasource/check_connection.dart';
import 'package:bloc_use/presentacion/pages/add_homework.dart';
import 'package:bloc_use/presentacion/pages/edit_homework.dart';
import 'package:bloc_use/presentacion/pages/menu_options.dart';
import 'package:flutter/material.dart';
// import 'package:homework_crud/data/datasource/check_connection.dart';
// import 'package:homework_crud/presentacion/pages/add_homework.dart';
// import 'package:homework_crud/presentacion/pages/edit_homework.dart';
// import 'package:homework_crud/presentacion/pages/menu_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final internetCheck = CheckConnection();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuOptions(),
        '/add': (context) => AddHomework(),
        '/edit': (context) => EditHomework()
      },
    );
  }
}
