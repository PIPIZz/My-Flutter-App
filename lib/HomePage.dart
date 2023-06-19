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
  @override
  //work first
  void initState() {
    super.initState();
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
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              proflie.displayName!,
              style: const TextStyle(fontSize: 30),
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
