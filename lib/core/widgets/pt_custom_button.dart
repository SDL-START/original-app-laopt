import 'package:flutter/material.dart';
import 'package:insuranceapp/core/constants/app_colors.dart';

class PTCustomButton extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final GestureTapCallback? onTap;
  const PTCustomButton({super.key, this.icon, this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: (icon != null)
            ? Row(
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      label.optional,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            : Center(
                child: Text(
                  label.optional,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      ),
    );
  }
}
extension StringUtil on String? {
  String get optional {
    return this??"";
  }
}
