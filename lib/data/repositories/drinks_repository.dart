import '../../domain/entities/drink.dart';
import '../../domain/repositories/drinks_repository.dart' as domain;
import '../datasources/mock_drinks_data_source.dart';

class DrinksRepositoryImpl implements domain.DrinksRepository {
  DrinksRepositoryImpl({MockDrinksDataSource? dataSource})
      : _dataSource = dataSource ?? MockDrinksDataSource();

  final MockDrinksDataSource _dataSource;

  @override
  List<Drink> getDrinks() {
    return _dataSource.getDrinks().map((model) => model.toEntity()).toList();
  }
}

