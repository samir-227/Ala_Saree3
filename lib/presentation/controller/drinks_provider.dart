import 'package:flutter/foundation.dart';
import 'package:ala_saree3/domain/entities/drink_filters.dart';

import '../../domain/entities/drink.dart';
import '../../domain/repositories/drinks_repository.dart';


class DrinksProvider extends ChangeNotifier {
  DrinksProvider({required DrinksRepository repository})
      : _repository = repository {
    loadDrinks();
  }

  final DrinksRepository _repository;
 
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<Drink> _drinks = [];
  List<Drink> get drinks => List.unmodifiable(_drinks);

  DrinkFilters _filters = const DrinkFilters();
  DrinkFilters get filters => _filters;

  /// Filtered list based on search and filter state.
  List<Drink> get filteredDrinks {
    
    var filteredList = _drinks;
    final searchQuery = _filters.searchQuery.trim().toLowerCase();
    
    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((drink) {
        return drink.name.toLowerCase().contains(searchQuery) ||
            (drink.title.toLowerCase().contains(searchQuery));
      }).toList();
    }

    if (_filters.priceMin != null) {
      filteredList = filteredList.where((drink) {
        final price = drink.priceValue;
        return price != null && price >= _filters.priceMin!;
      }).toList();
    }

    if (_filters.priceMax != null) {
      filteredList = filteredList.where((drink) {
        final price = drink.priceValue;
        return price != null && price <= _filters.priceMax!;
      }).toList();
    }

    if (_filters.category != null && _filters.category!.isNotEmpty) {
      filteredList = filteredList.where((drink) => drink.category == _filters.category).toList();
    }

    if (_filters.size != null && _filters.size!.isNotEmpty) {
      filteredList = filteredList
          .where((drink) => drink.availableSizes.contains(_filters.size))
          .toList();
    }
    return filteredList;
    
  }

  List<String> get categories =>
      _drinks.map((drink) => drink.category).whereType<String>().toSet().toList()..sort();

  void setSearchQuery(String value) {
    if (_filters.searchQuery == value) return;
    _filters = _filters.copyWith(searchQuery: value);
    notifyListeners();
  }

  void setFilters(DrinkFilters value) {
    _filters = value;
    notifyListeners();
  }

  void clearFilters() {
    final query = _filters.searchQuery;
    _filters = DrinkFilters(searchQuery: query);
    notifyListeners();
  }

 Future<void> loadDrinks() async {
  if (_isLoading || _drinks.isNotEmpty) return;

  _isLoading = true;
  notifyListeners();

  final result = await _repository.getDrinks();
  _drinks..clear()..addAll(result);

  _isLoading = false;
  notifyListeners();
}

}
