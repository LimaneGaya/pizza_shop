
import 'dart:convert';

import 'package:food_delivery/features/shop/domain/entities/macro.dart';

class MacrosModel extends Macros {

  const MacrosModel({
    required super.calories,
    required super.proteins,
    required super.fat,
    required super.carbs,
  });

  MacrosModel.fromMacros(Macros macros)
      : this(
          calories: macros.calories,
          proteins: macros.proteins,
          fat: macros.fat,
          carbs: macros.carbs,
        );

  MacrosModel copyWith({
    int? calories,
    int? proteins,
    int? fat,
    int? carbs,
  }) {
    return MacrosModel(
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'proteins': proteins,
      'fat': fat,
      'carbs': carbs,
    };
  }

  factory MacrosModel.fromMap(Map<String, dynamic> map) {
    return MacrosModel(
      calories: map['calories']?.toInt() ?? 0,
      proteins: map['proteins']?.toInt() ?? 0,
      fat: map['fat']?.toInt() ?? 0,
      carbs: map['carbs']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MacrosModel.fromJson(String source) => MacrosModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Macros(calories: $calories, proteins: $proteins, fat: $fat, carbs: $carbs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MacrosModel &&
      other.calories == calories &&
      other.proteins == proteins &&
      other.fat == fat &&
      other.carbs == carbs;
  }

  @override
  int get hashCode {
    return calories.hashCode ^
      proteins.hashCode ^
      fat.hashCode ^
      carbs.hashCode;
  }
}