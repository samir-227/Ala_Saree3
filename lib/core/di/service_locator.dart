import 'package:get_it/get_it.dart';
import '../../data/repositories/drinks_repository.dart';
import '../../data/repositories/foods_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../domain/repositories/drinks_repository.dart';
import '../../domain/repositories/foods_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../presentation/controller/cart_provider.dart';
import '../../presentation/controller/drinks_provider.dart';
import '../../presentation/controller/foods_provider.dart';
import '../../presentation/controller/order_provider.dart';
import '../../presentation/controller/theme_provider.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Repositories
  sl.registerLazySingleton<DrinksRepository>(() => DrinksRepositoryImpl());
  sl.registerLazySingleton<FoodsRepository>(() => FoodsRepositoryImpl());
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());

  // Providers (Controllers)
  sl.registerLazySingleton(() => ThemeProvider());
  sl.registerLazySingleton(() => CartProvider());
  sl.registerFactory(() => DrinksProvider(repository: sl()));
  sl.registerFactory(() => FoodsProvider(repository: sl()));
  sl.registerFactory(() => OrderProvider(repository: sl()));
}
