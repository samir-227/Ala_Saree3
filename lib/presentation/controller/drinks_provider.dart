import 'package:ala_saree3/core/services/product_filter_service.dart';
import 'package:flutter/foundation.dart';
import 'package:ala_saree3/domain/entities/product_filters.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/drinks_repository.dart';

class DrinksProvider extends ChangeNotifier {
  DrinksProvider({required DrinksRepository repository})
    : _repository = repository {
    loadDrinks();
  }

  final DrinksRepository _repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<ProductEntity> _drinks = [];
  List<ProductEntity> get drinks => List.unmodifiable(_drinks);

  ProductFilters _filters = const ProductFilters();
  ProductFilters get filters => _filters;

  List<ProductEntity> get filteredDrinks {
    return ProductFilterService.filterProducts(
      items: _drinks,
      filters: _filters,
      nameGetter: (d) => d.name,
      descriptionGetter: (d) => d.description,
      priceGetter: (d) => d.priceValue,
      categoryGetter: (d) => d.category,
      sizesGetter: (d) => d.availableSizes,
    );
  }

  List<String> get categories =>
      _drinks
          .map((drink) => drink.category)
          .whereType<String>()
          .toSet()
          .toList()
        ..sort();

  void setSearchQuery(String value) {
    if (_filters.searchQuery == value) return;
    _filters = _filters.copyWith(searchQuery: value);
    notifyListeners();
  }

  void setFilters(ProductFilters value) {
    _filters = value;
    notifyListeners();
  }

  void clearFilters() {
    final query = _filters.searchQuery;
    _filters = ProductFilters(searchQuery: query);
    notifyListeners();
  }

  Future<void> loadDrinks() async {
    if (_isLoading || _drinks.isNotEmpty) return;

    _isLoading = true;
    notifyListeners();

    final result = await _repository.getDrinks();
    _drinks
      ..clear()
      ..addAll(result);

    _isLoading = false;
    notifyListeners();
  }
}
