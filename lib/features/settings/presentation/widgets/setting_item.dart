import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final GestureTapCallback? onTap;
  final Widget? trailing;
  const SettingsItem({
    super.key,
    this.icon,
    this.title,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
          size: 20,
        ),
        title: Text(
          title ?? '',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
