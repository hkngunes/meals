import 'package:flutter/material.dart';
import 'package:meals/widgets/filter_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
  });
  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _isGlutenFreeChecked = false;
  bool _isLactoseFreeChecked = false;
  bool _isVegetarianChecked = false;
  bool _isVeganChecked = false;

  @override
  void initState() {
    final activeFilters = ref.read(filtersNotifierProvider);
    _isGlutenFreeChecked = activeFilters[Filter.glutenFree]!;
    _isLactoseFreeChecked = activeFilters[Filter.lactoseFree]!;
    _isVegetarianChecked = activeFilters[Filter.vegetarian]!;
    _isVeganChecked = activeFilters[Filter.vegan]!;
    super.initState();
  }

  void _onChange(String title, bool isCheck) {
    switch (title) {
      case "Gluten-Free":
        {
          setState(() {
            _isGlutenFreeChecked = isCheck;
          });
          break;
        }
      case "Lactose-Free":
        {
          setState(() {
            _isLactoseFreeChecked = isCheck;
          });
          break;
        }
      case "Vegetarian":
        {
          setState(() {
            _isVegetarianChecked = isCheck;
          });
          break;
        }
      case "Vegan":
        {
          setState(() {
            _isVeganChecked = isCheck;
          });
          break;
        }
      default:
        {
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filtersNotifierProvider.notifier).setFilters({
            Filter.glutenFree: _isGlutenFreeChecked,
            Filter.lactoseFree: _isLactoseFreeChecked,
            Filter.vegetarian: _isVegetarianChecked,
            Filter.vegan: _isVeganChecked,
          });
          return true;
        },
        child: Column(
          children: [
            FilterItem(
              isChecked: _isGlutenFreeChecked,
              title: "Gluten-Free",
              subtitle: "Only Gluten-Free meals are shown.",
              onChange: _onChange,
            ),
            FilterItem(
              isChecked: _isLactoseFreeChecked,
              title: "Lactose-Free",
              subtitle: "Only Lactose-Free meals are shown.",
              onChange: _onChange,
            ),
            FilterItem(
              isChecked: _isVegetarianChecked,
              title: "Vegetarian",
              subtitle: "Only Vegetarian meals are shown.",
              onChange: _onChange,
            ),
            FilterItem(
              isChecked: _isVeganChecked,
              title: "Vegan",
              subtitle: "Only Vegan meals are shown.",
              onChange: _onChange,
            ),
          ],
        ),
      ),
    );
  }
}
