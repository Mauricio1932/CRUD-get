import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/Local.dart';
import '../models/local_model.dart';

abstract class UserLocalDataSource {
  Future<List<LocalModel>> getLocals();
  Future<String> createLocal(Local local);
  Future<String> updateLocal(Local local);
  Future<String> deleteLocal(String id);
}

class ApiUserLocalDataSource implements UserLocalDataSource {
  final String apiUrl = 'https://fakestoreapi.com/products';

  @override
  Future<List<LocalModel>> getLocals() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body.map((dynamic item) => LocalModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load locals');
    }
  }

  @override
  Future<String> createLocal(Local local) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: LocalModel.fromEntity(local).toJson());

    if (response.statusCode == 201) {
      return 'Local creado exitosamente';
    } else {
      throw Exception('Failed to create local');
    }
  }

  @override
  Future<String> updateLocal(Local local) async {
    final response = await http.put(Uri.parse('$apiUrl/${local.id}'),
        headers: {'Content-Type': 'application/json'},
        body: LocalModel.fromEntity(local).toJson());

    if (response.statusCode == 200) {
      return 'Local actualizado exitosamente';
    } else {
      throw Exception('Failed to update local');
    }
  }

  @override
  Future<String> deleteLocal(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return 'Local eliminado exitosamente';
    } else {
      throw Exception('Failed to delete local');
    }
  }
}
