import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _activeScreenIndex = 0;

  void _onSelect(index) {
    setState(() {
      _activeScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const CategoriesScreen();
    Text activeTitle = const Text("Categories");

    if (_activeScreenIndex == 1) {
      activeScreen = const MealsScreen(meals: []);
      activeTitle = const Text("Your Favorites");
    }

    return Scaffold(
      appBar: AppBar(
        title: activeTitle,
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
