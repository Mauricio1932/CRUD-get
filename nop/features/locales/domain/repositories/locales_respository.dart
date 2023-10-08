import 'package:dio/dio.dart';
import '../../data/models/locales_model.dart';

class LocalesRepository {
  final Dio _client = Dio(BaseOptions(
    baseUrl: 'https://fakestoreapi.com/products',
  ));

  Future<List<Locales>> getProducts() async {
    final res = await _client.get('');

    return (res.data as List)
        .map(
          (json) => Locales(
            id: json['id'],   
            title: json['title'],
            image: json['image'],
          ),
        )
        .toList();
  }
}
