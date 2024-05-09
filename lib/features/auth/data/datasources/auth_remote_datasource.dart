import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/core/entities/my_user.dart';

abstract interface class AuthRemoteDatasource {
  Future<MyUser> signIn(String email, String password);
  Future<MyUser> signUp(String email, String password);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDatasourceImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<MyUser> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
