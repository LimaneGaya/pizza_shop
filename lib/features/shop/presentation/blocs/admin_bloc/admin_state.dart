part of 'admin_bloc.dart';

abstract class AdminState{
  const AdminState();
}

class AdminError extends AdminState {
  final String message;
  const AdminError({required this.message});
}
class AdminInitial extends AdminState {}
class AdminLoading extends AdminState {}
class CreatePizzaSuccess extends AdminState {}
class CreatePizzaError extends AdminState {
  final String message;
  const CreatePizzaError({required this.message});
}

