import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:esolink/views/constants/colors.dart';
import 'package:flutter/material.dart';


showErrorSnackBar(BuildContext? context, {String? title, content}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: AwesomeSnackbarContent(
      title: '$title',
      message: '$content',
      contentType: ContentType.failure,
    ),
    backgroundColor: Colors.transparent,
  ));
}



showMessageSnackBar(BuildContext? context, {String? title, content}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: AwesomeSnackbarContent(
      color: primaryColor,
      title: '$title',
      message: '$content',
      contentType: ContentType.success,
    ),
    backgroundColor: Colors.white,
  ));
}
