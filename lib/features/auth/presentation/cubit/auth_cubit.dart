import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_delivery/core/entities/my_user.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<MyUser?> _userSubscription;
  AuthCubit(this._authRepository) : super(const AuthInitial(user: null)) {
    _userSubscription = _authRepository.user.listen((user) {
      if (user == null) {
        emit(const AuthInitial(user: null));
      } else {
        emit(AuthSuccess(user: user));
      }
    });
  }
  
  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading(user: state.user));
    final user = await _authRepository.signUp(email, password, name);
    emit(AuthSuccess(user: user));
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading(user: state.user));
    final user = await _authRepository.signIn(email, password);
    emit(AuthSuccess(user: user));
  }

  void setUserData(MyUser user) => _authRepository.setUserData(user);

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(const AuthInitial(user: null));
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    return super.close();
  }
}
