import 'package:flutter/foundation.dart';

import '../../domain/entities/food.dart';
import '../../domain/repositories/foods_repository.dart';

/// Filter state for food menu (search + price/category/size).
class FoodFilters {
  const FoodFilters({
    this.searchQuery = '',
    this.priceMin,
    this.priceMax,
    this.category,
    this.size,
  });

  final String searchQuery;
  final double? priceMin;
  final double? priceMax;
  final String? category;
  final String? size;

  FoodFilters copyWith({
    String? searchQuery,
    double? priceMin,
    double? priceMax,
    String? category,
    String? size,
  }) {
    return FoodFilters(
      searchQuery: searchQuery ?? this.searchQuery,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      category: category ?? this.category,
      size: size ?? this.size,
    );
  }
}

/// Provider for managing foods state.
/// Business logic lives here, not in UI widgets.
/// Depends on domain abstractions, not data implementations.
class FoodsProvider extends ChangeNotifier {
  FoodsProvider({required FoodsRepository repository})
    : _repository = repository {
    loadFoods();
  }

  final FoodsRepository _repository;

  final List<Food> _foods = [];
  List<Food> get foods => List.unmodifiable(_foods);

  FoodFilters _filters = const FoodFilters();
  FoodFilters get filters => _filters;

  /// Filtered list based on search and filter state.
  List<Food> get filteredFoods {
    var list = _foods;
    final q = _filters.searchQuery.trim().toLowerCase();
    if (q.isNotEmpty) {
      list =
          list.where((f) {
            return f.name.toLowerCase().contains(q) ||
                f.description.toLowerCase().contains(q);
          }).toList();
    }
    if (_filters.priceMin != null) {
      list =
          list.where((f) {
            final p = f.priceValue;
            return p != null && p >= _filters.priceMin!;
          }).toList();
    }
    if (_filters.priceMax != null) {
      list =
          list.where((f) {
            final p = f.priceValue;
            return p != null && p <= _filters.priceMax!;
          }).toList();
    }
    if (_filters.category != null && _filters.category!.isNotEmpty) {
      list = list.where((f) => f.category == _filters.category).toList();
    }
    if (_filters.size != null && _filters.size!.isNotEmpty) {
      list =
          list.where((f) => f.availableSizes.contains(_filters.size)).toList();
    }
    return list;
  }

  List<String> get categories =>
      _foods.map((f) => f.category).whereType<String>().toSet().toList()
        ..sort();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setSearchQuery(String value) {
    if (_filters.searchQuery == value) return;
    _filters = _filters.copyWith(searchQuery: value);
    notifyListeners();
  }

  void setFilters(FoodFilters value) {
    _filters = value;
    notifyListeners();
  }

  void clearFilters() {
    final query = _filters.searchQuery;
    _filters = FoodFilters(searchQuery: query);
    notifyListeners();
  }

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
