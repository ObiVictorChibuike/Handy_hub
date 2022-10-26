import 'package:esolink/logic/registration/registration_validation.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationBloc with RegistrationValidation {
  final _userType = BehaviorSubject<String>();
  final _customerID = BehaviorSubject<int>();
  final _firstName = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _businessName = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();
  final _catgoryID = BehaviorSubject<String>();
  final _stateID = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _referralCode = BehaviorSubject<String>();
  final _termAndCondition = BehaviorSubject<bool>();

  Stream<String> get userType => _userType.stream;

  Stream<int> get customerID => _customerID.stream;

  Stream<String> get firstName =>
      _firstName.stream.transform(textFieldValidation);
  Stream<String> get lastName =>
      _lastName.stream.transform(textFieldValidation);
  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(phoneNumberValidation);
  Stream<String> get email => _email.stream.transform(emailValidation);
  Stream<String> get address => _address.stream.transform(textFieldValidation);
  Stream<String> get categoryID => _catgoryID.stream;

  Stream<String> get businessName =>
      _businessName.stream.transform(textFieldValidation);
  Stream<String> get stateOfResidence =>
      _stateID.stream.transform(textFieldValidation);
  Stream<String> get password => _password.stream.transform(passwordValidation);
  Stream<String> get referralCode => _referralCode.stream;

  Stream<bool> get termsAndCondition =>
      _termAndCondition.stream.transform(termsAndConditionValidation);

  addUserType(String? e) => _userType.sink.add(e!);
  addCustomerID(int? e) => _customerID.sink.add(e!);
  addEmail(String? e) => _email.sink.add(e!);
  addFirstName(String? e) => _firstName.sink.add(e!);
  addLastName(String? e) => _lastName.sink.add(e!);
  addPhone(String? e) => _phoneNumber.sink.add(e!);
  addBusinessName(String? e) => _businessName.sink.add(e!);
  addAddress(String? e) => _address.sink.add(e!);
  addCatgoryID(String? e) => _catgoryID.sink.add(e!);
  addState(String? e) => _stateID.sink.add(e!);
  addPassword(String? e) => _password.sink.add(e!);
  addReferralCode(String? e) => _referralCode.sink.add(e ?? "00000");
  void addTermsAndConditions(bool? e) => _termAndCondition.sink.add(e!);

  Stream<bool> get isSet => Rx.combineLatest([
        customerID,
        firstName,
        lastName,
        phoneNumber,
        email,
        address,
        categoryID,
        businessName,
        stateOfResidence,
        password,
        termsAndCondition
      ], (values) => true);

  //
  //
  // Rx.combineLatestList([

  //     ], (a,b,c,d,e,f,g,h,i,j,k,l) => true);

  dispose() {
    _userType.drain(null);
    _termAndCondition.close();
    _password.close();
    _stateID.close();
    _businessName.close();
    _referralCode.close();
    _address.close();
    _customerID.close();
    _email.close();
    _phoneNumber.close();
    _lastName.close();
    _firstName.close();
  }

  get body => {
        "serviceProviderId": 0,
        "customerTypeId": _customerID.value,
        "firstName": _firstName.value,
        "lastName": _lastName.value,
        "phoneNumber": _phoneNumber.value,
        "email": _email.value,
        "businessName": _businessName.value,
        "address": _address.value,
        "categoryId": int.tryParse(_catgoryID.value),
        "stateId": int.tryParse(_stateID.value),
        "password": _password.value,
        "referralCode": _referralCode.valueOrNull,
        "termsAndCondition": _termAndCondition.value
      };
}
