import 'package:food_delivery/core/entities/my_user.dart';
import 'package:food_delivery/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepositoryImpl({
    required AuthRemoteDatasource authRemoteDatasource,
  }) : _authRemoteDatasource = authRemoteDatasource;

  @override
  Stream<MyUser?> get user => _authRemoteDatasource.user;

  @override
  Future<void> setUserData(MyUser user) async{
    try {
      return await _authRemoteDatasource.setUserData(user);
    } catch (e, _) {
      rethrow;
    }
  }
   @override
  Future<MyUser> signUp(String email, String password, String name) async{
    try {
      final user = await _authRemoteDatasource.signUp(email, password);
      await setUserData(user.copyWith(name: name));
      return user;
    } catch (e, _) {
      rethrow;
    }
  }

  @override
  Future<MyUser> signIn(String email, String password) async {
    try {
      return await _authRemoteDatasource.signIn(email, password);
    } catch (e, _) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async{
    try {
      return await _authRemoteDatasource.signOut();
    } catch (e, _) {
      rethrow;
    }
  }

 
}
