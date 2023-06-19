import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('users').snapshots();
  final proflie = FirebaseAuth.instance.currentUser!;

  String fullName = '';

  @override
  //work first
  void initState() {
    super.initState();
    getDataById();
  }

  void getDataById() async {
    try {
      // Retrieve a reference to the document using the provided ID
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(proflie.uid)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          // String? fullName = data['fullname'] as String?;
          // print(data['fullName']);
          setState(() {
            this.fullName = data['fullname'];
          });
        } else {
          print('Document does not exist');
        }
      }
    } catch (e) {
      // Handle any errors that occur during data retrieval
      print('Error retrieving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/giphy.gif',
              width: double.infinity,
              height: 400,
            ),
            Text(
              "Greeting",
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "$fullName",
              style: TextStyle(fontSize: 30),
            ),
             const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .signOut()
                      .then((res) => {Navigator.pop(context)});
                },
                icon: const Icon(Icons.logout_sharp),
                label: const Text("Sign Out")),
          ],
        ),
      ),
    );
  }
}
