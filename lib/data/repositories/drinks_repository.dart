import '../../domain/entities/product.dart';
import '../../domain/repositories/drinks_repository.dart' as domain;
import '../datasources/mock_drinks_data_source.dart';

class DrinksRepositoryImpl implements domain.DrinksRepository {
  DrinksRepositoryImpl({MockDrinksDataSource? dataSource})
    : _dataSource = dataSource ?? MockDrinksDataSource();

  final MockDrinksDataSource _dataSource;

  @override
  Future<List<ProductEntity>> getDrinks() async {
    return await _dataSource
        .getDrinks()
        .map((model) => model.toEntity())
        .toList();
  }
}
