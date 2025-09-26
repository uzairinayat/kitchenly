import 'package:flutter/material.dart';
import 'package:kitchenly/services/recipe_api.dart';

class RecipeProvider extends ChangeNotifier {
  List<dynamic> _recipes = [];
  List<dynamic> _filteredRecipes = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get recipes => _filteredRecipes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch Recipes
  Future<void> loadRecipes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _recipes = await RecipeApi.fetchRecipes();
      _filteredRecipes = _recipes;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Searching
  void searchRecipes(String query) {
    if (query.isEmpty) {
      _filteredRecipes = _recipes;
    } else {
      _filteredRecipes = _recipes
          .where(
            (recipe) =>
                recipe['name'].toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  //  Sorting
  void sortRecipesByName({bool ascending = true}) {
    _filteredRecipes.sort((a, b) {
      final nameA = (a['name'] ?? '').toString().toLowerCase();
      final nameB = (b['name'] ?? '').toString().toLowerCase();
      return ascending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
    });
    notifyListeners();
  }

}
