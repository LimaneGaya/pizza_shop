part of 'auth_cubit.dart';

abstract class AuthState {
  final MyUser? user;
  const AuthState({required this.user});

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class AuthInitial extends AuthState {
  AuthInitial({required super.user});
}

class AuthLoading extends AuthState {
  AuthLoading({required super.user});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message, required super.user});
}

class AuthSuccess extends AuthState {
  AuthSuccess({required super.user});
}
