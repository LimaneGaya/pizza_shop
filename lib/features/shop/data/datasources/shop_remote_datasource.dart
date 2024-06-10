import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery/features/shop/data/models/pizza_model.dart';

abstract interface class ShopRemoteDatasource {
  Future<List<PizzaModel>> getPizzas();
  Future<String> getStorageUrl(String name);
  Future<void> createPizza(Uint8List imageData, PizzaModel pizza);
}

class ShopRemoteDatasourceImpl implements ShopRemoteDatasource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  late final CollectionReference<Map<String, dynamic>> pizzaCollection =
      _firebaseFirestore.collection('pizzas/');

  ShopRemoteDatasourceImpl({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage;

  @override
  Future<List<PizzaModel>> getPizzas() async {
    return await pizzaCollection.get().then((fSnapshot) {
      return fSnapshot.docs
          .map((fDoc) => PizzaModel.fromMap(fDoc.data()..['id'] = fDoc.id))
          .toList();
    });
  }

  @override
  Future<String> getStorageUrl(String name) async {
    return await _firebaseStorage.ref().child(name).getDownloadURL();
  }

  @override
  Future<void> createPizza(Uint8List imageData, PizzaModel pizza) async {
    final name = DateTime.now().millisecondsSinceEpoch.toString();
    
    await _firebaseStorage
        .ref('pizzas')
        .child(name)
        .putData(imageData, SettableMetadata(contentType: pizza.picture));
    pizza = pizza.copyWith(picture: name);
    await pizzaCollection.add(pizza.toMap());
  }
}
