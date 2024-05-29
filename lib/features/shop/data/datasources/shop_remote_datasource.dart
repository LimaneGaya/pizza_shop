import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/features/shop/data/models/pizza_model.dart';

abstract interface class ShopRemoteDatasource {
  Future<List<PizzaModel>> getPizzas();
}

class ShopRemoteDatasourceImpl implements ShopRemoteDatasource {
  final FirebaseFirestore _firebaseFirestore;
  late final CollectionReference<Map<String, dynamic>> pizzaCollection =
      _firebaseFirestore.collection('pizzas/');

  ShopRemoteDatasourceImpl({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  @override
  Future<List<PizzaModel>> getPizzas() async {
    return await pizzaCollection.get().then((fSnapshot) {
      return fSnapshot.docs
          .map((fDoc) => PizzaModel.fromMap(fDoc.data()))
          .toList();
    });
  }
}
