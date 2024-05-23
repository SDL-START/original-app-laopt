import 'package:flutter/material.dart';

class BuildItem extends StatelessWidget {
  final String? label;
  final String? value;
  final Color? color;
  final TextAlign? textAlign;
  final Function()? onTap;
  const BuildItem({
    super.key,
    this.value,
    this.color,
    this.textAlign,
    this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label ?? '',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value ?? '',
              textAlign: textAlign ?? TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                color: color ?? Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
