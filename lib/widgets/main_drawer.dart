import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer_list_tile.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Cooking Up!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 30,
                      ),
                ),
              ],
            ),
          ),
          const MainDrawerListTile(
            icon: Icons.set_meal,
            text: "Meals",
          ),
          const MainDrawerListTile(
            icon: Icons.star,
            text: "Favorites",
          ),
          const MainDrawerListTile(
            icon: Icons.settings,
            text: "Filters",
          ),
        ],
      ),
    );
  }
}
