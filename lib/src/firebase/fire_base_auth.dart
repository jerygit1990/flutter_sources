import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class FirAuth {
  static final int errTypeEmail = 1;
  static final int errTypePass = 2;
  static final int errTypeCommon = 3;

  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess) {
    _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      _createUser(user.uid, name, phone, onSuccess);
    }).catchError((err) {
      // TODO error handling
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess) {
    var user = Map<String, String>();
    user["name"] = name;
    user["phone"] = phone;

    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((vl) {
      print("on value: SUCCESSED");
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
    }).whenComplete(() {
      print("completed");
    });
  }

  ///
  Future signUp2(
      String email, String pass, Function(int, String) onRegisterError) async {
    final FirebaseUser _user = await _fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((vl) {
      print("onvalue: ");
    }).catchError((err) {
      if (_isInvalidEmail(err.code, onRegisterError)) {
        return;
      }
      if (_isInvalidPassword(err.code, onRegisterError)) {
        return;
      }
      //PlatformException
      print("errors: " + err.code);
      print(err);
    });

//    print(_user);
//    print(_user.email);
//    print(_user.toString());

//    _firebaseAuth.currentUser().then((us) {
//      UserUpdateInfo p = new UserUpdateInfo();
//      p.displayName = "Mr. Jery";
//      us.updateProfile(p);
//    });
//    _testAddUser(_user.uid);

    ///
  }

  ///

  bool _isInvalidEmail(String code, Function(int, String) onRegisterError) {
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError(errTypeEmail, "Email không hợp lệ");
        return true;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError(errTypeEmail, "Email đã tồn tại");
        return true;
      default:
        return false;
    }
  }

  bool _isInvalidPassword(String code, Function(int, String) onRegisterError) {
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError(errTypeEmail, "Email không hợp lệ");
        return true;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError(errTypeEmail, "Email đã tồn tại");
        return true;
      default:
        return false;
    }
  }

  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }
}
