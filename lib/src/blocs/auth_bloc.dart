import 'dart:async';

import 'package:fl_uberapp/src/firebase/fire_base_auth.dart';

class AuthBloc {
  FirAuth fir = new FirAuth();
//  StreamController _nameController = new StreamController();
//  Stream get _nameStream => _nameController.stream;
//  StreamController _phoneController = new StreamController();
//  Stream get _phoneStream => _nameController.stream;

  void dispose() {
//    _nameController.close();
//    _phoneController.close();
  }

  void checkValidateAndSignUp(String email, String pass, String name,
      String phone, Function onSuccess) {
//    if (name == null || name.length == 0) {
//      _nameController.sink.addError("Nhập tên");
//      return;
//    }
    fir.signUp(email, pass, name, phone, onSuccess);
  }
}
