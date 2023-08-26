import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/widgets/meal_scrollable_text.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  void _showFavoriteStatus(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).clearSnackBars();
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _onPressedFavoriteButton(BuildContext ctx, WidgetRef ref) {
    final isAdded =
        ref.read(favoriteNotifierProvider.notifier).toggleFavoriteStatus(meal);
    _showFavoriteStatus(ctx,
        isAdded ? "Meal added to Favorites." : "Meal removed from Favorite.");
  }

  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteNotifierProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              _onPressedFavoriteButton(context, ref);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 500,
              ),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(animation),
                  alignment: Alignment.topLeft,
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10,
          ),
          child: Column(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: MealScrollableText(meal: meal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
