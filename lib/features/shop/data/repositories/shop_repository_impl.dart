import 'package:food_delivery/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:food_delivery/features/shop/domain/entities/pizza.dart';
import 'package:food_delivery/features/shop/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDatasource _shopRemoteDatasource;

  ShopRepositoryImpl({
    required ShopRemoteDatasource shopRemoteDatasource,
  }) : _shopRemoteDatasource = shopRemoteDatasource;

  @override
  Future<List<Pizza>> getPizzas() async {
    try {
      final list = await _shopRemoteDatasource.getPizzas();
      for (int i = 0; i < list.length; i++) {
        final url = await _shopRemoteDatasource.getStorageUrl("pizzas/${list[i].picture}");
        list[i] = list[i].copyWith(picture: url);
      }
      return list;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
