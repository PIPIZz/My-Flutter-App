import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> SingInWithEmailandPassword(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // print(user);
  }

  Future<void> RegisterWithEmailandPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        if (userCredential.user != null) {
          User? user = userCredential.user;
          await user!.updateDisplayName(name);
          User? updatedUser = FirebaseAuth.instance.currentUser;
          print('Display Name Updated: ${updatedUser!.displayName}');
          // You can navigate to a new screen or perform any other action here
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> checkAuth() async {
    final user = await _auth.currentUser;
  }
}
