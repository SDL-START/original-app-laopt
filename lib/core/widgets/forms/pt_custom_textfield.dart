import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../constants/app_colors.dart';

class PTCustomTextField extends FormBuilderFieldDecoration<String> {
  final TextEditingController? controller;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final TextCapitalization textCapitalization;

  final TextStyle? style;

  final StrutStyle? strutStyle;

  final TextAlign textAlign;

  final TextAlignVertical? textAlignVertical;

  final TextDirection? textDirection;

  final bool autofocus;

  final String obscuringCharacter;

  final bool obscureText;

  final bool autocorrect;

  final SmartDashesType? smartDashesType;

  final SmartQuotesType? smartQuotesType;

  final bool enableSuggestions;

  final int? maxLines;

  final int? minLines;

  final bool expands;

  final bool? showCursor;

  static const int noMaxLength = -1;

  final int? maxLength;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String?>? onSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final double cursorWidth;

  final Radius? cursorRadius;

  final Color? cursorColor;

  final ui.BoxHeightStyle selectionHeightStyle;

  final ui.BoxWidthStyle selectionWidthStyle;

  final Brightness? keyboardAppearance;

  final EdgeInsets scrollPadding;

  final bool enableInteractiveSelection;

  final DragStartBehavior dragStartBehavior;

  bool get selectionEnabled => enableInteractiveSelection;

  final GestureTapCallback? onTap;

  final MouseCursor? mouseCursor;

  final InputCounterWidgetBuilder? buildCounter;

  final ScrollPhysics? scrollPhysics;

  final ScrollController? scrollController;

  final Iterable<String>? autofillHints;

  PTCustomTextField({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<String>? validator,
    Function? onFoundError,
    String? initialValue,
    bool readOnly = false,
    InputDecoration? decoration,
    ValueChanged<String?>? onChanged,
    ValueTransformer<String?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<String>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforcement,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.keyboardType,
    this.style = const TextStyle(color: Colors.black),
    this.controller,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.enableSuggestions = false,
    this.textAlignVertical,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollController,
    this.scrollPhysics,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.smartDashesType,
    this.smartQuotesType,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.autofillHints,
    this.obscuringCharacter = '•',
    this.mouseCursor,
  })  : assert(minLines == null || minLines > 0),
        assert(maxLines == null || maxLines > 0),
        assert(
          (minLines == null) || (maxLines == null) || (maxLines >= minLines),
          'minLines can\'t be greater than maxLines',
        ),
        assert(
          !expands || (minLines == null && maxLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength > 0),
        super(
            key: key,
            initialValue: controller != null ? controller.text : initialValue,
            name: name,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            autovalidateMode: autovalidateMode,
            onSaved: onSaved,
            enabled: enabled,
            onReset: onReset,
            decoration: decoration ?? const InputDecoration(),
            focusNode: focusNode,
            builder: (FormFieldState<String?> field) {
              final state = field as _PTCustomTextFieldState;

              if (onFoundError != null) {
                onFoundError(field.errorText);
              }
              return Column(
                children: [
                  TextField(
                    onChanged: onChanged,
                    controller: state._effectiveController,
                    focusNode: state.effectiveFocusNode,
                    decoration: state.decoration,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    style: style,
                    strutStyle: strutStyle,
                    textAlign: textAlign,
                    textAlignVertical: textAlignVertical,
                    textDirection: textDirection,
                    textCapitalization: textCapitalization,
                    autofocus: autofocus,
                    readOnly: readOnly,
                    showCursor: showCursor,
                    obscureText: obscureText,
                    autocorrect: autocorrect,
                    enableSuggestions: enableSuggestions,
                    maxLengthEnforcement: maxLengthEnforcement,
                    maxLines: maxLines,
                    minLines: minLines,
                    expands: expands,
                    maxLength: maxLength,
                    onTap: onTap,
                    onEditingComplete: onEditingComplete,
                    onSubmitted: onSubmitted,
                    inputFormatters: inputFormatters,
                    enabled: state.enabled,
                    cursorWidth: cursorWidth,
                    cursorRadius: cursorRadius,
                    cursorColor: cursorColor ?? AppColors.primaryColor,
                    scrollPadding: scrollPadding,
                    keyboardAppearance: keyboardAppearance,
                    enableInteractiveSelection: enableInteractiveSelection,
                    buildCounter: buildCounter,
                    dragStartBehavior: dragStartBehavior,
                    scrollController: scrollController,
                    scrollPhysics: scrollPhysics,
                    selectionHeightStyle: selectionHeightStyle,
                    selectionWidthStyle: selectionWidthStyle,
                    smartDashesType: smartDashesType,
                    smartQuotesType: smartQuotesType,
                    mouseCursor: mouseCursor,
                    obscuringCharacter: obscuringCharacter,
                    autofillHints: autofillHints,
                  ),
                  Container(height: 20)
                ],
              );
            });
  @override
  FormBuilderFieldDecorationState<FormBuilderFieldDecoration<String>, String>
      createState() => _PTCustomTextFieldState();
}

class _PTCustomTextFieldState
    extends FormBuilderFieldDecorationState<PTCustomTextField, String> {
  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: initialValue);
    _controller!.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller!.removeListener(_handleControllerChanged);
    if (null == widget.controller) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController!.text = initialValue ?? '';
    });
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController!.text != value) {
      _effectiveController!.text = value!;
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value) {
      didChange(_effectiveController!.text);
    }
  }
}
