import 'package:flutter/material.dart';
import 'package:meals/widgets/filter_item.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.activeFilters,
  });
  final Map<Filter, bool> activeFilters;
  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFreeChecked = false;
  bool _isLactoseFreeChecked = false;
  bool _isVegetarianChecked = false;
  bool _isVeganChecked = false;

  @override
  void initState() {
    _isGlutenFreeChecked = widget.activeFilters[Filter.glutenFree]!;
    _isLactoseFreeChecked = widget.activeFilters[Filter.lactoseFree]!;
    _isVegetarianChecked = widget.activeFilters[Filter.vegetarian]!;
    _isVeganChecked = widget.activeFilters[Filter.vegan]!;
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
          Navigator.of(context).pop(
            {
              Filter.glutenFree: _isGlutenFreeChecked,
              Filter.lactoseFree: _isLactoseFreeChecked,
              Filter.vegetarian: _isVegetarianChecked,
              Filter.vegan: _isVeganChecked,
            },
          );
          return false;
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
