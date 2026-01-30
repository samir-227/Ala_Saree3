import 'package:flutter/foundation.dart';

import '../../domain/entities/drink.dart';
import '../../domain/repositories/drinks_repository.dart';


class DrinksProvider extends ChangeNotifier {
  DrinksProvider({required DrinksRepository repository})
      : _repository = repository;

  final DrinksRepository _repository;

  final List<Drink> _drinks = [];
  List<Drink> get drinks => List.unmodifiable(_drinks);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void loadDrinks() {
    if (_isLoading || _drinks.isNotEmpty) return;

    _isLoading = true;
    notifyListeners();

    // Synchronous for now since it's just a mock data source.
    _drinks.clear();
    _drinks.addAll(_repository.getDrinks());

    _isLoading = false;
    notifyListeners();
  }
}
