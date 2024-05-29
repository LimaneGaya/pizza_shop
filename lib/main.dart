import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:food_delivery/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:food_delivery/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_delivery/features/auth/presentation/pages/welcome_screen.dart';
import 'package:food_delivery/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:food_delivery/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:food_delivery/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:food_delivery/features/shop/presentation/pages/home_screen.dart';
import 'package:food_delivery/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(AuthRepositoryImpl(
          authRemoteDatasource: AuthRemoteDatasourceImpl(
              firebaseAuth: FirebaseAuth.instance,
              firebaseFirestore: FirebaseFirestore.instance))),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return switch (state) {
            AuthSuccess _ => BlocProvider(
                create: (context) => ShopBloc(
                    shopRepository: ShopRepositoryImpl(
                        shopRemoteDatasource: ShopRemoteDatasourceImpl(
                            firebaseFirestore: FirebaseFirestore.instance))),
                child: const HomeScreen(),
              ),
            AuthLoading _ =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
            _ => const WelcomeScreen(),
          };
        },
      ),
    );
  }
}
