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
    String fullname,  String email, String password) async {
    try {
      final db = FirebaseFirestore.instance;

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // User created successfully
      User? user = userCredential.user;

      final data = <String, dynamic>{
        'email': email,
        'uid': user!.uid,
        'fullname': fullname
      };

      final newUsers = db.collection("users").doc(user!.uid);

// Later...
      newUsers.set(data);
      // Save email in Firestore
      // await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      //   'email': email,
      //   'uid': user.uid,
      //   'fullname' :
      // });
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> checkAuth() async {
    final user = await _auth.currentUser;
  }
}
