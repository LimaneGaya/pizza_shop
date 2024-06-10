import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_delivery/routes.dart';
import 'package:food_delivery/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(BlocProvider<AuthCubit>(
    create: (context) => sl<AuthCubit>(),
    child: const MainApp(),
  ));
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter(context),
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }
}


