import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:food_delivery/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:food_delivery/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_delivery/features/auth/presentation/pages/splash_screen.dart';
import 'package:food_delivery/features/auth/presentation/pages/welcome_screen.dart';
import 'package:food_delivery/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:food_delivery/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:food_delivery/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:food_delivery/features/shop/presentation/pages/create_screen.dart';
import 'package:food_delivery/features/shop/presentation/pages/home_screen.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:go_router/go_router.dart';

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

final _goRouterKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _goRouter,
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }
}

final _goRouter = GoRouter(
  navigatorKey: _goRouterKey,
  redirect: (context, state) {
    final isLogged = context.read<AuthCubit>().state is AuthSuccess;
    if (!isLogged) return '/auth';
    return null;
  },
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) {
        return const WelcomeScreen();
      },
    ),
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) {
        return ShellShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return BlocProvider(
              create: (context) => ShopBloc(
                  shopRepository: ShopRepositoryImpl(
                      shopRemoteDatasource: ShopRemoteDatasourceImpl(
                          firebaseFirestore: FirebaseFirestore.instance,
                          firebaseStorage: FirebaseStorage.instance)))
                ..add(GetPizzas()),
              child: const HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: '/create',
          builder: (context, state) => const CreatePizzaScreen(),
        ),
      ],
    ),
  ],
);

class ShellShell extends StatelessWidget {
  final Widget child;
  const ShellShell({
    required this.child,
    super.key,
  });

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
              onPressed: () async {}, child: const Icon(CupertinoIcons.cart)),
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
                context.go('/auth');
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line)),
          IconButton(
              onPressed: () {
                context.go('/create');
              },
              icon: const Icon(CupertinoIcons.add))
        ],
      ),
      body: child,
    );
  }
}
