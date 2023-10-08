import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/User.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<List<UserModel>> getUsers();
  Future<String> createUser(User user);
  Future<String> updateUser(User user);
  Future<String> deleteUser(String id);
  Future<UserModel> login(User user);
}

class ApiUserDataSource implements UserDataSource {
  final String apiUrl;

  ApiUserDataSource({required this.apiUrl});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body.map((dynamic item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<String> createUser(User user) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: UserModel.fromEntity(user).toJson());

    if (response.statusCode == 201) {
      return 'User created successfully';
    } else {
      throw Exception('Failed to create user');
    }
  }

  @override
  Future<String> updateUser(User user) async {
    final response = await http.put(Uri.parse('$apiUrl/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: UserModel.fromEntity(user).toJson());

    if (response.statusCode == 200) {
      return 'User updated successfully';
    } else {
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<String> deleteUser(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return 'User deleted successfully';
    } else {
      throw Exception('Failed to delete user');
    }
  }

  @override
  Future<UserModel> login(User user) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'name': user.name,
        'password': user.password,
      }),
    );

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);

      return UserModel.fromJson(body);
    } else {
      throw Exception('Failed to log in');
    }
  }
}
