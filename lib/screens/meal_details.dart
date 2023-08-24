import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: Center(
        child: Column(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            const SizedBox(
              height: 8,
            ),
            Text("Complexity: " + complexityText),
            Text("Affordablity: " + affordabilityText),
            if (meal.isGlutenFree) Text("Gluten Free!"),
            if (meal.isLactoseFree) Text("Lactose Free!"),
            if (meal.isVegan) Text("Vegan!"),
            if (meal.isVegetarian) Text("Vegetarian!"),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Ingredients:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            for (final ing in meal.ingredients) Text(ing),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Steps:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            for (final step in meal.steps) Text(step),
          ],
        ),
      ),
    );
  }
}
