import 'package:flutter/material.dart';

import '../../logic/toggle_password_visibility/toggle_password_visibility_bloc.dart';
import '../constants/text_decoration.dart';

convertToCurrency(String e) {
  String newStr = e.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[0]},");
  return newStr;
}

formatPhone(String e) {
  final String replaced = e.startsWith('0') ? e.replaceFirst('0', '234') : e;
  return replaced;
}

class PlainTextField extends StatelessWidget {
  PlainTextField(
      {Key? key,
      this.label,
      this.hint,
      this.stream,
      this.onChanged,
      this.maxLines,
      this.enabled,
      this.onTap,
      this.controller,
      this.readOnly,
      this.obscureText,
      this.trailing,
      this.initialValue,
      this.currency = false,
      this.keyboardType})
      : super(key: key);

  final String? label, hint, initialValue;
  final Stream? stream;
  final Widget? trailing;
  final Function(String? e)? onChanged;
  final int? maxLines;
  final bool? enabled;
  final void Function()? onTap;
  final bool? readOnly;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final bool? currency;

  final TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label",
                  style: subHeaderText.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  // textCapitalization: TextCapitalization.none,
                  keyboardType: keyboardType ?? TextInputType.text,
                  initialValue: initialValue,
                  controller: controller,
                  onTap: onTap,
                  obscureText: obscureText ?? false,
                  onChanged: !currency!
                      ? onChanged
                      : (e) {
                          onChanged!(e.replaceAll(",", ""));
                          String convertedText =
                              convertToCurrency(e.replaceAll(",", ""));
                          if (controller != null) {
                            controller!.value = controller!.value.copyWith(
                                text: convertedText,
                                selection: TextSelection.collapsed(
                                    offset: convertedText.length));
                          } else {
                            amount.value = amount.value.copyWith(
                                text: convertedText,
                                selection: TextSelection.collapsed(
                                    offset: convertedText.length));
                          }
                        },
                  maxLines: maxLines ?? 1,
                  enabled: enabled ?? true,
                  readOnly: readOnly ?? false,
                  decoration: InputDecoration(
                      suffix: trailing,
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      hintText: hint,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 15)),
                )
              ],
            );
          }),
    );
  }
}

class PlainTextFieldII extends StatelessWidget {
  PlainTextFieldII(
      {Key? key,
      this.label,
      this.hint,
      this.stream,
      this.onChanged,
      this.maxLines,
      this.enabled,
      this.onTap,
      this.controller,
      this.readOnly,
      this.obscureText,
      this.trailing,
      this.initialValue,
      this.keyboardType,
      this.label2,
      this.currency = false})
      : super(key: key);

  final String? label, label2, hint, initialValue;
  final Stream? stream;
  final Widget? trailing;
  final Function(String? e)? onChanged;
  final int? maxLines;
  final bool? enabled;
  final void Function()? onTap;
  final bool? readOnly;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;

  final bool? currency;

  final TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label",
                  style: subHeaderText.copyWith(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "$label2",
                  style: subHeaderText.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextFormField(
                  keyboardType: keyboardType ?? TextInputType.text,
                  initialValue: initialValue,
                  controller: controller,
                  onTap: onTap,
                  obscureText: obscureText ?? false,
                  onChanged: !currency!
                      ? onChanged
                      : (e) {
                          onChanged!(e.replaceAll(",", ""));
                          String convertedText =
                              convertToCurrency(e.replaceAll(",", ""));
                          if (controller != null) {
                            controller!.value = controller!.value.copyWith(
                                text: convertedText,
                                selection: TextSelection.collapsed(
                                    offset: convertedText.length));
                          } else {
                            amount.value = amount.value.copyWith(
                                text: convertedText,
                                selection: TextSelection.collapsed(
                                    offset: convertedText.length));
                          }
                        },
                  maxLines: maxLines ?? 1,
                  enabled: enabled ?? true,
                  readOnly: readOnly ?? false,
                  decoration: InputDecoration(
                      suffix: trailing,
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      hintText: hint,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 15)),
                )
              ],
            );
          }),
    );
  }
}

class SelectField extends StatelessWidget {
  const SelectField(
      {Key? key,
      this.hint,
      this.info,
      this.items,
      this.stream,
      this.label,
      this.onchanged})
      : super(key: key);

  final String? label;
  final String? hint;
  final Widget? info;
  final List<String>? items;
  final Stream? stream;
  final void Function(String? e)? onchanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label",
            style: subHeaderText.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            onChanged: onchanged,
            isDense: true,
            items: [
              DropdownMenuItem(
                enabled: false,
                onTap: () {},
                child: Text(hint!,
                    overflow: TextOverflow.ellipsis, style: subHeaderText),
              ),
              ...items!
                  .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                        enabled: true,
                        value: e,
                        onTap: () {},
                        child: Text(
                          e,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ))
                  .toList()
            ],
            hint: Text(
              "$hint",
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color(0xff999999),
                  fontSize: 14),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
          )
        ],
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField(
      {Key? key,
      this.hint,
      this.label,
      this.stream,
      this.onchanged,
      this.number,
      this.leading,
      this.controller})
      : super(key: key);

  final String? label;
  final String? hint;
  final Stream? stream;
  final Function(String e)? onchanged;
  final bool? number;
  final Widget? leading;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    TogglePasswordVisibilityBloc togglePasswordVisibilityBloc =
        TogglePasswordVisibilityBloc();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: label != null,
            child: Text(
              "$label",
              style: subHeaderText,
            ),
          ),
          Visibility(
            visible: label != null,
            child: const SizedBox(
              height: 10,
            ),
          ),
          StreamBuilder(
              stream: stream,
              builder: (context, s) {
                return StreamBuilder<bool>(
                    initialData: true,
                    stream: togglePasswordVisibilityBloc.showPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: controller,
                        obscureText: snapshot.data ?? true,
                        onChanged: onchanged,
                        keyboardType: number == true
                            ? const TextInputType.numberWithOptions()
                            : null,
                        decoration: InputDecoration(
                            hintText: hint,
                            prefixIcon: leading == null
                                ? null
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                      top: 15,
                                      bottom: 15,
                                    ),
                                    child: leading,
                                  ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: StreamBuilder<bool>(
                                  initialData: false,
                                  stream: togglePasswordVisibilityBloc
                                      .passwordShown,
                                  builder: (context, snapshot) {
                                    return InkWell(
                                        onTap: () =>
                                            togglePasswordVisibilityBloc
                                                .toggleShowPassword(),
                                        // ignore: unrelated_type_equality_checks
                                        child: snapshot.data!
                                            ? const Icon(
                                                Icons.visibility_off,
                                                size: 20,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                Icons.visibility,
                                                size: 20,
                                                color: Colors.black,
                                              ));
                                  }),
                            ),
                            errorText: s.hasError ? s.error.toString() : null,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 15)),
                      );
                    });
              })
        ],
      ),
    );
  }
}
