import '../../domain/entities/food.dart';
import '../../domain/repositories/foods_repository.dart' as domain;
import '../datasources/mock_foods_data_source.dart';

class FoodsRepositoryImpl implements domain.FoodsRepository {
  FoodsRepositoryImpl({MockFoodsDataSource? dataSource})
    : _dataSource = dataSource ?? MockFoodsDataSource();

  final MockFoodsDataSource _dataSource;

  @override
  List<Food> getFoods() {
    return _dataSource.getFoods().map((model) => model.toEntity()).toList();
  }
}
