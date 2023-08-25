import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meal_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _activeScreenIndex = 0;

  void _onSelect(index) {
    setState(() {
      _activeScreenIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "Filters") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  List<Meal> _filterMeals(List<Meal> meals) {
    final activeFilters = ref.watch(filtersNotifierProvider);
    final List<Meal> result = [];
    for (final meal in meals) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        continue;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        continue;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        continue;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        continue;
      }
      result.add(meal);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    Widget activeScreen = CategoriesScreen(
      filteredMeals: _filterMeals(meals),
    );
    Text activeTitle = const Text("Categories");

    final favoriteMeals = ref.watch(favoriteNotifierProvider);

    if (_activeScreenIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
      );
      activeTitle = const Text("Your Favorites");
    }

    return Scaffold(
      appBar: AppBar(
        title: activeTitle,
      ),
      drawer: MainDrawer(
        onSelect: _selectScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onSelect,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorite",
          ),
        ],
        currentIndex: _activeScreenIndex,
      ),
    );
  }
}
