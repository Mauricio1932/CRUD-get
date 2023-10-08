// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:http/http.dart' as http;

// ignore_for_file: avoid_print

import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<List<User>> getUsers();
}

class ApiUserDatasourceImp implements UserDataSource {
  //getx
  RxList<UserModel> posts = RxList();
  RxBool isLoading = true.obs;
  RxBool isListViewScrollToTheDown = false.obs;
  RxBool isInternetConnect = true.obs;

  final String apiUrl = 'https://fakestoreapi.com/auth/login';
  final String userUrl = 'https://jsonplaceholder.typicode.com/posts';

  final String getUser = 'http://localhost:3000/api/user/viewAll';
  final String userCreate ='http://localhost:3000/api/user/createUser';
  final String deleteuser ='http://localhost:3000/api/user/delete';
  final String updateuser ='http://localhost:3000/api/user/update';
  // final Dio dio = Dio();
  // late SharedPreferences sharedPreferences;

  @override
  Future<List<User>> getUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Dio dio = Dio();
    isInternrtConnect();
    isInternetConnect();
    var body;
    bool success = false;
    print("¿Hay internet? : $isInternetConnect");

    if (isInternetConnect.isTrue) {
      final response = await http.get(Uri.parse(getUser));
      print("locales ${response.request}");

      body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        success = true;
      }
    } else {
      String userString = sharedPreferences.getString('users') ?? "[]";
      body = jsonDecode(userString);
      success = true;
    }

    if (success) {
      List<User> users =
          body.map<User>((voluntary) => UserModel.fromJson(voluntary)).toList();
      sharedPreferences.setString('users', jsonEncode(users));

      return users;
    } else {
      // Agrega lógica adicional si es necesario para manejar el caso de error.
      // Puedes lanzar una excepción, devolver una lista vacía, etc.
      String message = body['error_code'].toString() + ' - ' + body['message'];
      throw Exception(message);
    }
  }

  Future<void> isInternrtConnect() async {
    isInternetConnect.value = await InternetConnectionChecker().hasConnection;
  }
  // @override
  // Future<List<UserLoginModel>> login(User user) async {
  //   Response response;

  //   try {
  //     response = await dio.post(
  //       apiUrl,
  //       data: {
  //         'username': user.username,
  //         'password': user.password,
  //       },
  //     );
  //   } catch (e) {
  //     print("Error: $e");
  //     throw Exception("Failed to log in");
  //   }

  //   if (response.statusCode == 200) {
  //     print("Status 200 OK");
  //     final token = response.data['token'];
  //     await saveAuthToken(token);

  //     return token; // Ahora el tipo de retorno es String
  //   } else {
  //     print("Error en el login, estado: ${response.statusCode}");
  //     throw Exception('Failed to log in');
  //   }
  // }

  // Future<void> saveAuthToken(String token) async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();

  //   // Guardar el token en 'auth_token'
  //   await sharedPreferences.setString('auth_token', token);

  //   // Puedes imprimir el token para verificar que se haya guardado correctamente
  //   print("Token guardado: $token");
  // }

  // @override
  // Future<List<CreateUserLoginModel>> userCreate(UserCreate user) async {
  //   Response response;

  //   try {
  //     response = await dio.post(
  //       userUrl,
  //       data: {
  //         'username': user.username,
  //         'password': user.password,
  //         'email': user.email,
  //       },
  //     );
  //   } catch (e) {
  //     print("Error: $e");
  //     throw Exception("Failed to log in");
  //   }

  //   if (response.statusCode == 200) {
  //     print("Status 201 OK");
  //     // final token = response.data['token'];

  //     // await saveAuthToken(token);

  //     return response.data; // Ahora el tipo de retorno es String
  //   } else {
  //     print("Error en el login, estado: ${response.statusCode}");
  //     throw Exception('Failed to log in');
  //   }
  // }
}
