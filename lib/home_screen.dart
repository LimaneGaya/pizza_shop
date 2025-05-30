import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_delivery/features/shop/presentation/pages/home_screen_admin.dart';
import 'package:food_delivery/features/shop/presentation/pages/home_screen_user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthCubit>().state.user!;
    if (kDebugMode) print(user);
    
    return user.isAdmin
        ? const HomeScreenAdmin()
        : const HomeScreenUser();
  }
}
