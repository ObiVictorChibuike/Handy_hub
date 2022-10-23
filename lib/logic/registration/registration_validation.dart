import 'dart:async';

mixin RegistrationValidation {
  StreamTransformer<String, String> emailValidation =
      StreamTransformer.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty ||
        !email.trim().contains(RegExp(
            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"))) {
      sink.addError("Enter a valid email address");
    } else {
      sink.add(email.trim());
    }
  });

  StreamTransformer<String, String> textFieldValidation =
      StreamTransformer.fromHandlers(handleData: (data, sink) {
    if (data.isEmpty) {
      sink.addError("Field cannot be empty");
    } else {
      sink.add(data);
    }
  });

  StreamTransformer<String, String> passwordValidation =
      StreamTransformer.fromHandlers(handleData: (password, sink) {
    if (password.isEmpty || password.length < 8) {
      sink.addError("Password Must contain 8 Characters or more");
    } else if (!password.contains(RegExp("^(?=.*[0-9])"))) {
      sink.addError("Password Must Contain at least one number");
    } else if (!password.contains(RegExp("(?=.*[a-z])"))) {
      sink.addError("Password Must contain one Lower case letter");
    } else if (!password.contains(RegExp("(?=.*[A-Z])"))) {
      sink.addError("Password Must contain one Upper case letter");
    } else if (!password.contains(RegExp(r"(?=.*?[#?!@$%^&*-])"))) {
      sink.addError("Password Must contain one special character");
    } else {
      sink.add(password.trim());
    }
  });

  StreamTransformer<String, String> firstNameValidation =
      StreamTransformer.fromHandlers(handleData: (field, sink) {
    if (field.isEmpty || field == null) {
      sink.addError("Please fill this field");
    } else {
      sink.add(field.trim());
    }
  });

  StreamTransformer<String, String> lastNameValidation =
      StreamTransformer.fromHandlers(handleData: (field, sink) {
    if (field.isEmpty || field == null) {
      sink.addError("Please fill this field");
    } else {
      sink.add(field);
    }
  });

  StreamTransformer<String, String> addressValidation =
      StreamTransformer.fromHandlers(handleData: (field, sink) {
    if (field.isEmpty || field == null) {
      sink.addError("Please fill this field");
    } else {
      sink.add(field);
    }
  });

  StreamTransformer<String, String> superAgentCodeValidation =
      StreamTransformer.fromHandlers(handleData: (field, sink) {
    if (field.isEmpty || field == null) {
      sink.addError("Please fill this field");
    } else {
      sink.add(field);
    }
  });

  StreamTransformer<String, String> phoneNumberValidation =
      StreamTransformer.fromHandlers(handleData: (phoneNumber, sink) {
    if (phoneNumber.isEmpty || phoneNumber == null) {
      sink.addError("Please enter your phone number");
    } else if (phoneNumber.length != 11 || int.tryParse(phoneNumber) == null) {
      sink.addError("Please enter a valid 11 digits phone number");
    } else {
      sink.add(phoneNumber.trim());
    }
  });

  StreamTransformer<bool, bool> termsAndConditionValidation =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (terms, sink) {
    if (terms != true) {
      sink.addError("Please accept terms and conditions to proceed");
    } else {
      sink.add(terms);
    }
  });
}
