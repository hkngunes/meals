import 'package:flutter/material.dart';
import 'package:meals/widgets/filter_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: Column(
        children: [
          FilterItem(
            isChecked: activeFilters[Filter.glutenFree]!,
            title: "Gluten-Free",
            subtitle: "Only Gluten-Free meals are shown.",
            onChange: (isChecked) {
              ref
                  .read(filtersNotifierProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
          ),
          FilterItem(
            isChecked: activeFilters[Filter.lactoseFree]!,
            title: "Lactose-Free",
            subtitle: "Only Lactose-Free meals are shown.",
            onChange: (isChecked) {
              ref
                  .read(filtersNotifierProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
          ),
          FilterItem(
            isChecked: activeFilters[Filter.vegetarian]!,
            title: "Vegetarian",
            subtitle: "Only Vegetarian meals are shown.",
            onChange: (isChecked) {
              ref
                  .read(filtersNotifierProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
          ),
          FilterItem(
            isChecked: activeFilters[Filter.vegan]!,
            title: "Vegan",
            subtitle: "Only Vegan meals are shown.",
            onChange: (isChecked) {
              ref
                  .read(filtersNotifierProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
          ),
        ],
      ),
    );
  }
}
