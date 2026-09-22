import 'package:dio/dio.dart';

import '../models/item_model.dart';


class ItemService {
  final Dio dio;

  ItemService({required this.dio});

  List<ItemModel> _items = [];

  List<ItemModel> get items => _items;

  Future<List<ItemModel>> fetchItems(String categoryUrl) async {
    try {
      final response = await dio.get(
        categoryUrl
      );
      final List<dynamic> data = response.data;

      _items = data
          .map((json) => ItemModel.fromJson(json))
          .toList();

      return _items;
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch items: ${e.message}',
      );
    }
  }
}