import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:meals/models/meal.dart";

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavoriteStatus(Meal meal) {
    final isAvailable = state.contains(meal);

    if (isAvailable) {
      state = state
          .where(
            (element) => element.id != meal.id,
          )
          .toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteNotifierProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
