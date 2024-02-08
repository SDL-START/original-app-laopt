import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';


class CustomPhoneTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialCountryCode;
  final String? hintText;
  final String? label;
  final String? initialValue;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final Function(PhoneNumber)? onChanged;
  // final void Function(Country)? onCountryChanged;
  const CustomPhoneTextfield({
    super.key,
    this.controller,
    this.hintText,
    this.initialCountryCode,
    this.label,
    this.validator,
    this.initialValue,
    this.onChanged,
    // this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: const TextStyle(color: Color.fromARGB(255, 142, 140, 140)),
        ),
        IntlPhoneField(
          key: key,
          controller: controller,
          initialCountryCode: initialCountryCode,
          disableLengthCheck: true,
          showCountryFlag: false,
          initialValue: initialValue,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          dropdownTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
          flagsButtonPadding: EdgeInsets.zero,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 16),
          ),
          validator: validator,
          onChanged: onChanged,
          // onCountryChanged: onCountryChanged,
        ),
      ],
    );
  }
}
