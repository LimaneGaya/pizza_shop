import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:food_delivery/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repository.dart';
import 'package:food_delivery/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_delivery/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:food_delivery/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:food_delivery/features/shop/domain/repositories/shop_repository.dart';
import 'package:food_delivery/features/shop/presentation/blocs/admin_bloc/admin_bloc.dart';
import 'package:food_delivery/features/shop/presentation/blocs/shop_bloc/shop_bloc.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Auth
  sl
    ..registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepository>()))
    ..registerLazySingleton<AuthRepository>(() =>
        AuthRepositoryImpl(authRemoteDatasource: sl<AuthRemoteDatasource>()))
    ..registerLazySingleton<AuthRemoteDatasource>(() =>
        AuthRemoteDatasourceImpl(
            firebaseAuth: FirebaseAuth.instance,
            firebaseFirestore: FirebaseFirestore.instance));
  //Shop
  sl
    ..registerFactory<ShopBloc>(
        () => ShopBloc(shopRepository: sl<ShopRepository>()))
    ..registerLazySingleton<ShopRepository>(() =>
        ShopRepositoryImpl(shopRemoteDatasource: sl<ShopRemoteDatasource>()))
    ..registerLazySingleton<ShopRemoteDatasource>(() =>
        ShopRemoteDatasourceImpl(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance));
  //Admin
  sl.registerFactory<AdminBloc>(() => AdminBloc(sl<ShopRepository>()));
}
