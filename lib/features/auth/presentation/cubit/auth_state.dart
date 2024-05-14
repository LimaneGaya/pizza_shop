part of 'auth_cubit.dart';

sealed class AuthState {
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
  const AuthInitial({required super.user});
}

class AuthLoading extends AuthState {
  const AuthLoading({required super.user});
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message, required super.user});
}

class AuthSuccess extends AuthState {
  const AuthSuccess({required super.user});
}
