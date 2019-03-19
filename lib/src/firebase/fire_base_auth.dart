import 'package:firebase_auth/firebase_auth.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signUp(String email, String pass) async {
    final FirebaseUser _user = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass);

    print(_user);
    print(_user.email);
    print(_user.toString());
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
