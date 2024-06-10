part of 'admin_bloc.dart';

abstract class AdminEvent {
  const AdminEvent();
}

class CreatePizza extends AdminEvent {
  final Uint8List imageData;
  final String picture;
  final bool isVeg;
  final int spicy;
  final String name;
  final String description;
  final int price;
  final int discount;
  final int calories;
  final int proteins;
  final int fat;
  final int carbs;

  const CreatePizza({
    required this.imageData,
    required this.picture,
    required this.isVeg,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carbs,
  });
}
