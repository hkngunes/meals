import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
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

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _activeScreenIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _filters = kInitialFilters;

  void _onSelect(index) {
    setState(() {
      _activeScreenIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "Filters") {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            activeFilters: _filters,
          ),
        ),
      );
      setState(() {
        _filters = result ?? kInitialFilters;
      });
    }
  }

  void _showFavoriteStatus(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _toggleFavoriteStatus(Meal meal) {
    bool isExist = _favoriteMeals.contains(meal);
    if (isExist) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showFavoriteStatus("Meal removed from your favorites");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showFavoriteStatus("Meal added to your favorites");
    }
  }

  List<Meal> _filterMeals(List<Meal> meals) {
    final List<Meal> result = [];
    for (final meal in meals) {
      if (_filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        continue;
      }
      if (_filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        continue;
      }
      if (_filters[Filter.vegetarian]! && !meal.isVegetarian) {
        continue;
      }
      if (_filters[Filter.vegan]! && !meal.isVegan) {
        continue;
      }
      result.add(meal);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      toggleFavoriteStatus: _toggleFavoriteStatus,
      filteredMeals: _filterMeals(dummyMeals),
    );
    Text activeTitle = const Text("Categories");

    if (_activeScreenIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        toggleFavoriteStatus: _toggleFavoriteStatus,
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
