part of 'shop_bloc.dart';

sealed class ShopState {}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoadSuccess extends ShopState {
  final List<Pizza> pizzas;
  ShopLoadSuccess(this.pizzas);
}

class ShopError extends ShopState {
  final String message;
  ShopError(this.message);
}
