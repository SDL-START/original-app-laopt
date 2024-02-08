import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sizer/sizer.dart';

class PTDropdownField<T> extends FormBuilderFieldDecoration<T> {
  PTDropdownField({
    super.key,
    required String name,
    FormFieldValidator<T>? validator,
    T? initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<T?>? onChanged,
    ValueTransformer<T?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<T>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    required List<dynamic> source,
    Function? onFoundError,
  }) : super(
            enabled: enabled,
            initialValue: initialValue,
            name: name,
            validator: validator,
            onChanged: onChanged,
            autovalidateMode: autovalidateMode,
            onSaved: onSaved,
            decoration: decoration,
            valueTransformer: valueTransformer,
            builder: (FormFieldState<T?> field) {
              final state = field as _PTDropdownState;
              void changeValue(T? value) {
                state.didChange(value);
              }

              if (onFoundError != null) {
                if (field.hasError) {
                  onFoundError(field.errorText);
                }
              }

              return Column(
                children: [
                  Sizer(
                    builder: (context, orientation, deviceType) {
                      return InputDecorator(
                        decoration: state.decoration.copyWith(
                          floatingLabelBehavior:
                              decoration.floatingLabelBehavior,
                        ),
                        isEmpty: state.value == '' || state.value == null,
                        child: Row(
                          children: [
                            field.value == null
                                ? Expanded(
                                    child: DropdownButtonHideUnderline(
                                    child: DropdownButton<T>(
                                      dropdownColor: Colors.white,
                                      isExpanded: true,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      items: source.map((e) {
                                        return DropdownMenuItem<T>(
                                          value: e,
                                          child: Text(
                                            "$e",
                                            overflow: TextOverflow.fade,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        );
                                      }).toList(),
                                      value: state.value,
                                      isDense: true,
                                      onChanged: state.enabled
                                          ? (value) => changeValue(value)
                                          : null,
                                    ),
                                  ))
                                : const SizedBox.shrink(),
                            if (field.value != null) ...[
                              SizedBox(
                                width: 90.w,
                                child: Text(
                                  "${field.value}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const Spacer(),
                              (state.enabled)
                                  ? InkWell(
                                      onTap: () => changeValue(null),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ]
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            });
  @override
  FormBuilderFieldDecorationState<FormBuilderFieldDecoration<T>, T>
      createState() => _PTDropdownState();
}

class _PTDropdownState<T>
    extends FormBuilderFieldDecorationState<PTDropdownField<T>, T> {}
