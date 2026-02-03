import '../entities/drink.dart';

abstract class DrinksRepository {
  Future<List<Drink>> getDrinks();
}
