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
      return await _shopRemoteDatasource.getPizzas();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  
}