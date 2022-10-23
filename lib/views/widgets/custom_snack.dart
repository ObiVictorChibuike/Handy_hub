import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../../logic/api_services/constants.dart';

showSnackBar(ContentType? contentType, {String? title, content}) {
  k.currentState?.showSnackBar(SnackBar(
    content: AwesomeSnackbarContent(
      title: '$title',
      message: '$content',
      contentType: contentType ?? ContentType.help,
    ),
    backgroundColor: Colors.transparent,
  ));
}
