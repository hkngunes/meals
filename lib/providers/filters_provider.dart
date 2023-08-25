import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super(
          {
            Filter.glutenFree: false,
            Filter.lactoseFree: false,
            Filter.vegan: false,
            Filter.vegetarian: false,
          },
        );
  void setFilters(Map<Filter, bool> newFilters) {
    state = newFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersNotifierProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final activeFilters = ref.watch(filtersNotifierProvider);
  final meals = ref.watch(mealsProvider);
  return meals
      .where((meal) =>
          !((activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) ||
              (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) ||
              (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) ||
              (activeFilters[Filter.vegan]! && !meal.isVegan)))
      .toList();
});
