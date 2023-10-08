import 'dart:convert';
// import 'package:localeats/features/locales/data/models/local_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/local_model.dart';

abstract class LocalApiDatasource {
  Future<List<LocalModel>> getLocals();
  Future<LocalModel> getSingleLocals(int local);
}

class ApiLocalDatasourceImp implements LocalApiDatasource {
  final String apiUrl = 'https://fakestoreapi.com/products/';

  @override
  Future<List<LocalModel>> getLocals() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<LocalModel> locals =
          body.map((dynamic item) => LocalModel.fromJson(item)).toList();

      List<Map<String, dynamic>> localMaps =
          locals.map((local) => local.toJson()).toList();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('productos', jsonEncode(localMaps));

      print("$sharedPreferences");

      return locals;
    } else {
      throw Exception('Failed to load locals');
    }
  }

  @override
  Future<LocalModel> getSingleLocals(int local) async {
    final response = await http.get(Uri.parse('$apiUrl/$local'));

    // print("petcion ${local}");
    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);

      final local = LocalModel.fromJson(jsonData);

      return local;
    } else {
      throw Exception('Failed to load product');
    }
  }
}
