import 'package:flutter/foundation.dart';

import '../../domain/entities/food.dart';
import '../../domain/repositories/foods_repository.dart';

/// Provider for managing foods state.
/// Business logic lives here, not in UI widgets.
/// Depends on domain abstractions, not data implementations.
class FoodsProvider extends ChangeNotifier {
  FoodsProvider({required FoodsRepository repository})
      : _repository = repository;

  final FoodsRepository _repository;

  final List<Food> _foods = [];
  List<Food> get foods => List.unmodifiable(_foods);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void loadFoods() {
    if (_isLoading || _foods.isNotEmpty) return;

    _isLoading = true;
    notifyListeners();

    _foods
      ..clear()
      ..addAll(_repository.getFoods());

    _isLoading = false;
    notifyListeners();
  }
}
