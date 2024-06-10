import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/shop/domain/repositories/shop_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final ShopRepository _shopRepository;
  AdminBloc(this._shopRepository) : super(AdminInitial()) {
    on<CreatePizza>(_createPizza);
  }

  Future<void> _createPizza(CreatePizza event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await _shopRepository.createPizza(
        imageData: event.imageData,
        picture: event.picture,
        isVeg: event.isVeg,
        spicy: event.spicy,
        name: event.name,
        description: event.description,
        price: event.price,
        discount: event.discount,
        calories: event.calories,
        proteins: event.proteins,
        fat: event.fat,
        carbs: event.carbs,
      );
      emit(CreatePizzaSuccess());
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }
}
