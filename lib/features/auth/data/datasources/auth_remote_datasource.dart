import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/features/auth/data/models/my_user_model.dart';

abstract interface class AuthRemoteDatasource {
  Stream<MyUserModel> get user;
  Future<void> setUserData(MyUserModel user);
  Future<MyUserModel> signIn(String email, String password);
  Future<MyUserModel> signUp(String email, String password);
  Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRemoteDatasourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  @override
  Stream<MyUserModel> get user =>
      _firebaseAuth.authStateChanges().asyncMap((fUser) async {
        if (fUser == null) return MyUserModel.empty();
        return await getData(fUser.uid);
      });

  Future<MyUserModel> getData(String uid) async {
    return await _firebaseFirestore.doc('users/$uid').get().then((fDoc) {
      if (fDoc.exists) return MyUserModel.fromMap(fDoc.data()!);
      return MyUserModel.empty();
    });
  }

  @override
  Future<MyUserModel> signIn(String email, String password) async {
    return await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((fUser) async => await getData(fUser.user!.uid));
  }

  @override
  Future<MyUserModel> signUp(String email, String password) async {
    return await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((fUser) async => await getData(fUser.user!.uid));
  }

  @override
  Future<void> setUserData(MyUserModel user) {
    // TODO: implement setUserData
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
