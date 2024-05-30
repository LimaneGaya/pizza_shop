import 'package:food_delivery/features/shop/data/models/macro_model.dart';
import 'package:food_delivery/features/shop/domain/entities/pizza.dart';

class PizzaModel extends Pizza {
  const PizzaModel({
    required super.pizzaId,
    required super.picture,
    required super.isVeg,
    required super.spicy,
    required super.name,
    required super.description,
    required super.price,
    required super.discount,
    required super.macros,
  });
  PizzaModel copyWith({
    String? pizzaId,
    String? picture,
    bool? isVeg,
    int? spicy,
    String? name,
    String? description,
    int? price,
    int? discount,
    MacrosModel? macros,
  }) {
    return PizzaModel(
      pizzaId: pizzaId ?? this.pizzaId,
      picture: picture ?? this.picture,
      isVeg: isVeg ?? this.isVeg,
      spicy: spicy ?? this.spicy,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      macros: macros ?? this.macros,
    );
  }

  PizzaModel.fromPizza(Pizza pizza)
      : this(
          pizzaId: pizza.pizzaId,
          picture: pizza.picture,
          isVeg: pizza.isVeg,
          spicy: pizza.spicy,
          name: pizza.name,
          description: pizza.description,
          price: pizza.price,
          discount: pizza.discount,
          macros: pizza.macros,
        );

  Map<String, dynamic> toMap() {
    return {
      'picture': picture,
      'isVeg': isVeg,
      'spicy': spicy,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'macros': MacrosModel.fromMacros(macros).toMap(),
    };
  }

  factory PizzaModel.fromMap(Map<String, dynamic> map) {
    return PizzaModel(
      pizzaId: map['id'] ?? '',
      picture: map['picture'] ?? '',
      isVeg: map['isVeg'] ?? false,
      spicy: map['spicy']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toInt() ?? 0,
      discount: map['discount']?.toInt() ?? 0,
      macros: MacrosModel.fromMap(map['macros']),
    );
  }
}
