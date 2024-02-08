// import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PTCustomPhoneField extends FormBuilderFieldDecoration<PhoneNumber> {
  final TextEditingController? controller;
  PTCustomPhoneField(
      {Key? key,
      String? initialCountryCode,
      String? hintText,
      bool disableLengthCheck = false,
      ValueChanged<Country>? onCountryChanged,
      bool showCountryFlag = false,
      TextStyle? style = const TextStyle(color: Colors.black),
      bool shouldRequestFocus = false,
      InputDecoration decoration =
          const InputDecoration(contentPadding: EdgeInsets.zero),
      String? initialValue,
      PhoneNumber? initialNumber,
      Function(PhoneNumber?)? valueTransformer,
      Function(PhoneNumber?)? onChanged,

      //From Super
      final FormFieldValidator<dynamic>? validator,
      required String name,
      this.controller})
      : super(
            validator: validator,
            name: name,
            key: key,
            valueTransformer: valueTransformer,
            decoration: decoration,
            initialValue: initialNumber,
            onChanged: onChanged,
            builder: (FormFieldState<PhoneNumber> field) {
              final state = field as _FormBuilderPhoneFieldState;
              return InputDecorator(
                decoration: state.decoration,
                child: IntlPhoneField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: state._effectiveController,
                  showCountryFlag: showCountryFlag,
                  disableLengthCheck: disableLengthCheck,
                  initialCountryCode: initialCountryCode ?? "LA",
                  initialValue: initialValue,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: hintText,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) => state.didChange(value),
                  style: style,
                  onCountryChanged: onCountryChanged,
                  focusNode: state.effectiveFocusNode,
                ),
              );
            });
  @override
  FormBuilderFieldDecorationState<FormBuilderFieldDecoration<PhoneNumber>,
      PhoneNumber> createState() => _FormBuilderPhoneFieldState();
}

class _FormBuilderPhoneFieldState
    extends FormBuilderFieldDecorationState<PTCustomPhoneField, PhoneNumber> {
  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(text: value == null ? '' : value.toString());
  }

  @override
  void dispose() {
    super.dispose();
    if (null == widget.controller) {
      _controller!.dispose();
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController!.text =
          initialValue == null ? "" : initialValue.toString();
    });
  }
}
