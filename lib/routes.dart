import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_delivery/features/auth/presentation/pages/welcome_screen.dart';
import 'package:food_delivery/features/shop/presentation/blocs/admin_bloc/admin_bloc.dart';
import 'package:food_delivery/features/shop/presentation/blocs/shop_bloc/shop_bloc.dart';
import 'package:food_delivery/features/shop/presentation/pages/create_screen.dart';
import 'package:food_delivery/home_screen.dart';
import 'package:food_delivery/service_locator.dart';
import 'package:go_router/go_router.dart';


final _goRouterKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

GoRouter goRouter(BuildContext context) => GoRouter(
  navigatorKey: _goRouterKey,
  redirect: (context, state) {
    final isLogged = context.read<AuthCubit>().state is AuthSuccess;
    if (!isLogged) return '/auth';
    return null;
  },
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const WelcomeScreen()
      ,
    ),
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) => ShellShell(child: child)
      ,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return BlocProvider(
              create: (context) => sl<ShopBloc>()..add(GetPizzas()),
              child: const HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: '/create',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AdminBloc>(),
            child: const CreatePizzaScreen(),
          ),
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
          if (GoRouterState.of(context).uri.toString() != '/create')
            IconButton(
                onPressed: () => context.go('/create'),
                icon: const Icon(CupertinoIcons.add))
        ],
      ),
      body: child,
    );
  }
}