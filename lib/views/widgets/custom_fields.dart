import 'package:esolink/models/states/states_model.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
      this.keyboardType, this.inputFormatters})
      : super(key: key);

  final String? label, hint, initialValue;
  final Stream? stream;
  final Widget? trailing;
  final List<TextInputFormatter>? inputFormatters;
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
                  inputFormatters: inputFormatters,
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

class PlainTextField3 extends StatelessWidget {
  PlainTextField3(
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
                  maxLines: maxLines ?? 5,
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

class CategoryField extends StatelessWidget {
  const CategoryField(
      {Key? key,
      this.label,
      this.hint,
      this.info,
      this.items,
      this.stream,
      this.value,
      this.onchanged})
      : super(key: key);

  final String? label;
  final String? hint;
  final Widget? info;
  final List<dynamic>? items;
  final Stream? stream;
  final String? value;
  final void Function(String? e)? onchanged;

  @override
  Widget build(BuildContext context) {
    items?.map((e) => e.categoryId);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
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
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                  fillColor: const Color(0xffF2F2F2),
                  hintStyle: GoogleFonts.montserrat(
                      color: const Color(0xff828282),
                      fontWeight: FontWeight.w300,
                      fontSize: 14)),
              isExpanded: true,
              value: items![0].categoryId == '' ? items![0].categoryId : '14',
              onChanged: onchanged!,
              isDense: true,
              items: [
                DropdownMenuItem(
                  enabled: false,
                  child: Text(
                    "$hint",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                ...items!
                    .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                          value: value != null ? "${e.categoryId}" : "$e",
                          onTap: () {},
                          child: Text(
                            "${e.name}",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                color: const Color(0xff828282),
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                        ))
                    .toList(),
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
      ),
    );
  }
}



class StateField extends StatelessWidget {
  const StateField(
      {Key? key,
      this.label,
      this.hint,
      this.info,
      this.items2,
      this.stream,
      this.value,
      this.onchanged})
      : super(key: key);

  final String? label;
  final String? hint;
  final Widget? info;
  final List<StateModel>? items2;
  final Stream? stream;
  final String? value;
  final void Function(String? e)? onchanged;

  @override
  Widget build(BuildContext context) {
    items2?.map((e) => e.stateId);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
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
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                  fillColor: const Color(0xffF2F2F2),
                  hintStyle: GoogleFonts.montserrat(
                      color: const Color(0xff828282),
                      fontWeight: FontWeight.w300,
                      fontSize: 14)),
              isExpanded: true,
              value: value,
              // value: items2![0].stateId == '' ? items2![0].stateId : '1',
              onChanged: onchanged!,
              isDense: true,
              items: [
                DropdownMenuItem(
                  enabled: false,
                  child: Text(
                    "$hint",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                ...items2!
                    .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                          value: "${e.stateId}",
                          onTap: () {},
                          child: Text(
                            "${e.stateName}",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                color: const Color(0xff828282),
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                        ))
                    .toList(),
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
      ),
    );
  }
}

class TextCheckBox extends StatelessWidget {
  const TextCheckBox({Key? key, this.text, this.stream, this.onchanged})
      : super(key: key);

  final Widget? text;
  final Stream<bool>? stream;
  final void Function(bool? e)? onchanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<bool>(
              stream: stream,
              builder: (context, snapshot) {
                return GestureDetector(
                  excludeFromSemantics: true,
                  child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(primaryColor),
                      value: snapshot.data ?? false,
                      onChanged: onchanged),
                );
              }),
          // SizedBox(
          //   width: 5,
          // ),
          Expanded(child: text!)
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
      this.controller,
        this.validator,
      })
      : super(key: key);

  final String? label;
  final String? hint;
  final Stream? stream;
  final Function(String e)? onchanged;
  final bool? number;
  final Widget? leading;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    TogglePasswordVisibilityBloc togglePasswordVisibilityBloc =
        TogglePasswordVisibilityBloc();
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
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
                        validator: validator,
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
