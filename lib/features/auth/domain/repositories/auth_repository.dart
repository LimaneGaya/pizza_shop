import 'package:food_delivery/core/entities/my_user.dart';

abstract interface class AuthRepository {
  Stream<MyUser> get user;
  Future<void> setUserData(MyUser user);
  Future<MyUser> signIn(String email, String password);
  Future<MyUser> signUp(String email, String password);
  Future<void> signOut();
}
