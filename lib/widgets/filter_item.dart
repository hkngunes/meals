import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.isChecked,
    required this.title,
    required this.subtitle,
    required this.onChange,
  });

  final bool isChecked;
  final String title;
  final String subtitle;
  final void Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: isChecked,
      onChanged: onChange,
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
