import 'dart:typed_data';

import 'package:food_delivery/features/shop/domain/entities/pizza.dart';

abstract interface class ShopRepository {
  Future<List<Pizza>> getPizzas();
  Future<void> createPizza({
    required Uint8List imageData,
    required String picture,
    required bool isVeg,
    required int spicy,
    required String name,
    required String description,
    required int price,
    required int discount,
    required int calories,
    required int proteins,
    required int fat,
    required int carbs,
  });
}
