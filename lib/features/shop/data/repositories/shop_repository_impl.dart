import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:food_delivery/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:food_delivery/features/shop/data/models/macro_model.dart';
import 'package:food_delivery/features/shop/data/models/pizza_model.dart';
import 'package:food_delivery/features/shop/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDatasource _shopRemoteDatasource;

  ShopRepositoryImpl({
    required ShopRemoteDatasource shopRemoteDatasource,
  }) : _shopRemoteDatasource = shopRemoteDatasource;

  @override
  Future<List<PizzaModel>> getPizzas() async {
    try {
      final list = await _shopRemoteDatasource.getPizzas();
      for (int i = 0; i < list.length; i++) {
        final url = await _shopRemoteDatasource
            .getStorageUrl("pizzas/${list[i].picture}");
        list[i] = list[i].copyWith(picture: url);
      }
      return list;
    } catch (e) {
      if (kDebugMode) print(e);
      
      rethrow;
    }
  }

  @override
  Future<void> createPizza(
      {required Uint8List imageData,
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
      required int carbs}) async {
    try {
      await _shopRemoteDatasource.createPizza(
          imageData,
          PizzaModel(
            pizzaId: "",
            picture: picture,
            isVeg: isVeg,
            spicy: spicy,
            name: name,
            description: description,
            price: price,
            discount: discount,
            macros: MacrosModel(
                calories: calories, proteins: proteins, fat: fat, carbs: carbs),
          ));
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }
}
