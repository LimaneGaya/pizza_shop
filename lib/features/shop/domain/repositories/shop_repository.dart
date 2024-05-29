import 'package:food_delivery/features/shop/domain/entities/pizza.dart';

abstract interface class ShopRepository {
  Future<List<Pizza>> getPizzas();
}