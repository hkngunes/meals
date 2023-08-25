import 'package:flutter/material.dart';

class MainDrawerListTile extends StatelessWidget {
  const MainDrawerListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onSelect,
  });

  final IconData icon;
  final String text;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 24),
      ),
      onTap: () {
        onSelect(text);
      },
    );
  }
}
