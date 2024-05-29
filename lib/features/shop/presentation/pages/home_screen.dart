import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_delivery/features/shop/data/models/pizza_model.dart';
import 'package:food_delivery/features/shop/domain/entities/macro.dart';
import 'package:food_delivery/features/shop/domain/entities/pizza.dart';
import 'package:food_delivery/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:food_delivery/features/shop/presentation/pages/details_screen.dart';

final pizzas = [
  Pizza(
    name: 'Margherita',
    price: 13,
    picture: '1.webp',
    description: 'Tomato, Mozzarella, Basil',
    macros: Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
    isVeg: true,
    pizzaId: '0',
    discount: 1,
    spicy: 0,
  ),
  Pizza(
    name: 'Peperoni',
    price: 13,
    picture: '2.webp',
    description: 'Tomato, Mozzarella, Basil',
    macros: Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
    isVeg: true,
    pizzaId: '0',
    discount: 1,
    spicy: 0,
  ),
  Pizza(
    name: 'Veggie',
    price: 13,
    picture: '3.webp',
    description: 'Tomato, Mozzarella, Basil',
    macros: Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
    isVeg: true,
    pizzaId: '0',
    discount: 1,
    spicy: 0,
  ),
  Pizza(
    name: 'Hawaiian',
    price: 13,
    picture: '4.webp',
    description: 'Tomato, Mozzarella, Basil',
    macros: Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
    isVeg: true,
    pizzaId: '0',
    discount: 1,
    spicy: 0,
  ),
  Pizza(
    name: 'Meat',
    price: 13,
    picture: '5.webp',
    description: 'Tomato, Mozzarella, Basil',
    macros: Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
    isVeg: true,
    pizzaId: '0',
    discount: 1,
    spicy: 0,
  ),
  Pizza(
    name: 'Cheese',
    price: 13,
    picture: '6.webp',
    description: 'Tomato, Mozzarella, Basil',
    macros: Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
    isVeg: true,
    pizzaId: '0',
    discount: 1,
    spicy: 0,
  ),
  Pizza(
    name: 'Vegan',
    price: 13,
    picture: '7.webp',
    description: 'Tomato, Mozzarella, Basil',
    macros: Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
    isVeg: true,
    pizzaId: '0',
    discount: 1,
    spicy: 0,
  ),
  Pizza(
    name: 'Chicken',
    price: 13,
    picture: '8.webp',
    description: 'Tomato, Mozzarella, Basil',
    macros: Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
    isVeg: true,
    pizzaId: '0',
    discount: 1,
    spicy: 0,
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Image.asset('assets/8.webp', scale: 14),
            const SizedBox(width: 8),
            const Text(
              'PIZZA',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            )
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Pizza p = Pizza(
                  name: 'Pizza',
                  price: 13,
                  picture: '9.webp',
                  description: 'Tomato, Mozzarella, Basil',
                  macros:
                      Macros(calories: 1200, proteins: 15, fat: 8, carbs: 12),
                  isVeg: true,
                  pizzaId: '0',
                  discount: 1,
                  spicy: 0,
                );
                final pz = p as PizzaModel;
              },
              child: const Icon(CupertinoIcons.cart)),
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            if (state is ShopLoadSuccess) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 9 / 16),
                  itemCount: state.pizzas.length,
                  itemBuilder: (context, int i) {
                    return Material(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  DetailsScreen(state.pizzas[i]),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(state.pizzas[i].picture),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: state.pizzas[i].isVeg
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        state.pizzas[i].isVeg
                                            ? "VEG"
                                            : "NON-VEG",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        state.pizzas[i].spicy == 1
                                            ? "🌶️ BLAND"
                                            : state.pizzas[i].spicy == 2
                                                ? "🌶️ BALANCE"
                                                : "🌶️ SPICY",
                                        style: TextStyle(
                                            color: state.pizzas[i].spicy == 1
                                                ? Colors.green
                                                : state.pizzas[i].spicy == 2
                                                    ? Colors.orange
                                                    : Colors.redAccent,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 10),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                state.pizzas[i].name,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                state.pizzas[i].description,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "\$${state.pizzas[i].price - (state.pizzas[i].price * (state.pizzas[i].discount) / 100)}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "\$${state.pizzas[i].price}.00",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.w700,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            CupertinoIcons.add_circled_solid))
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  });
            } else if (state is ShopLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("An error has occured..."),
              );
            }
          },
        ),
      ),
    );
  }
}
