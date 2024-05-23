import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

class DescriptionInputField extends StatelessWidget {
  final TextEditingController? controller;
  const DescriptionInputField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        controller: controller,
        maxLines: 2,
        decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: LocaleKeys.kDescription.tr(),
        ),
      ),
    );
  }
}
