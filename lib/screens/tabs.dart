import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

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

  void _onSelect(index) {
    setState(() {
      _activeScreenIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      toggleFavoriteStatus: _toggleFavoriteStatus,
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
      drawer: MainDrawer(),
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
