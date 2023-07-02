import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.title,
    this.callback,
  });

  final String title;
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: callback,
    );
  }
}
