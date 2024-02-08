import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final Function()? onTap;
  final String? label;
  final String? value;
  final TextAlign? textAlign;
  final Color? color;

  const DetailItem({
    super.key,
    this.onTap,
    this.label,
    this.value,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        // height: 200,
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
