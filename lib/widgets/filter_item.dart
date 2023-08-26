import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FilterItem extends ConsumerWidget {
  const FilterItem({
    super.key,
    required this.filter,
    required this.title,
    required this.subtitle,
  });

  final Filter filter;
  final String title;
  final String subtitle;

  void _setFilter(bool isChecked, Filter filter, WidgetRef ref) {
    ref.read(filtersNotifierProvider.notifier).setFilter(filter, isChecked);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersNotifierProvider);
    return SwitchListTile(
      value: activeFilters[filter]!,
      onChanged: (isChecked) {
        _setFilter(isChecked, filter, ref);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 30, right: 20),
    );
  }
}
