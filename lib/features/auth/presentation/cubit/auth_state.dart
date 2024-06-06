part of 'auth_cubit.dart';

sealed class AuthState {
  final MyUser? user;
  const AuthState({required this.user});

  @override
  operator ==(covariant AuthState other) {
    if (identical(this, other)) return true;
    return other.user?.uid == user?.uid &&
        other.user?.email == user?.email &&
        other.user?.name == user?.name &&
        other.user?.hasActiveCart == user?.hasActiveCart &&
        other.user?.isAdmin == user?.isAdmin;
  }

  @override
  int get hashCode => Object.hash(
        user?.uid,
        user?.email,
        user?.name,
        user?.hasActiveCart,
        user?.isAdmin,
      );
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
