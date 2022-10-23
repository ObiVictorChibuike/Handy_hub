import 'dart:async';

mixin LoginValidation {
  StreamTransformer<String, String> emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty ||
        !email.contains(RegExp(
            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"))) {
      sink.addError("Enter a valid email address");
    } else {
      sink.add(email);
    }
  });

  StreamTransformer<String, String> passwordValidation =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.isEmpty
        // !password.contains(RegExp(
        // r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,20}$"))) {
        ) {
      sink.addError("Enter your password");
    } else {
      sink.add(password.trim());
    }
  });
  StreamTransformer<String, String> fieldValidation =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.isEmpty) {
      sink.addError("This field cannot be empty");
    } else {
      sink.add(password.trim());
    }
  });
}
