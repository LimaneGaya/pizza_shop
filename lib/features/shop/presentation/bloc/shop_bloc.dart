import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/shop/domain/entities/pizza.dart';
import 'package:food_delivery/features/shop/domain/repositories/shop_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository _shopRepository;

  ShopBloc({
    required ShopRepository shopRepository,
  })  : _shopRepository = shopRepository,
        super(ShopInitial()) {
    on<ShopEvent>((event, emit) => emit(ShopLoading()));
    on<GetPizzas>(getPizzas);
    
  }

  void getPizzas(GetPizzas event, Emitter<ShopState> emit) async {
    try {
      final pizzas = await _shopRepository.getPizzas();
      emit(ShopLoadSuccess(pizzas));
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }
}
