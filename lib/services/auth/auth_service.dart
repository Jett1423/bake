import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      //sign user in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up

  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      //sign user up
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //log out

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
