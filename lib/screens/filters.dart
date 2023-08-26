import 'package:flutter/material.dart';
import 'package:meals/widgets/filter_item.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: const Column(
        children: [
          FilterItem(
            filter: Filter.glutenFree,
            title: "Gluten-Free",
            subtitle: "Only Gluten-Free meals are shown.",
          ),
          FilterItem(
            filter: Filter.lactoseFree,
            title: "Lactose-Free",
            subtitle: "Only Lactose-Free meals are shown.",
          ),
          FilterItem(
            filter: Filter.vegetarian,
            title: "Vegetarian",
            subtitle: "Only Vegetarian meals are shown.",
          ),
          FilterItem(
            filter: Filter.vegan,
            title: "Vegan",
            subtitle: "Only Vegan meals are shown.",
          ),
        ],
      ),
    );
  }
}
