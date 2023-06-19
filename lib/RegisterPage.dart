import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:myflutterapplication/LoginPage.dart';

import 'auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  // final _Registercontroller = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SingupWithEmailandPassword() async {
    try {
      final name = nameController.value.text;
      final email = emailController.value.text;
      final password = passwordController.value.text;
      await Auth()
          .RegisterWithEmailandPassword(name, email, password)
          .then((res) => {
                formkey.currentState!.reset(),
                Fluttertoast.showToast(
                    msg: "Sign Up Success", gravity: ToastGravity.CENTER),
                // print("register succes")
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }))
              });
    } on FirebaseAuthException catch (e) {
      String erorrMessage;
      
      if (e.code == 'weak-password') {
        erorrMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        erorrMessage = "The account already exists for that email.";
      }else{
        erorrMessage = e.message!;
      }

      Fluttertoast.showToast(
        msg: erorrMessage, 
        gravity: ToastGravity.CENTER
      );


    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        // toolbarHeight: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/loader-cat.gif',
                  width: double.infinity,
                  height: 250,
                ),
                const Text("Sign Up",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator:
                      ValidationBuilder().minLength(2).maxLength(50).build(),
                  autovalidateMode: AutovalidateMode.always,
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'FullName',
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: ValidationBuilder().email().maxLength(50).build(),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'E-mail',
                    icon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.always,
                  controller: passwordController,
                  validator:
                      ValidationBuilder().minLength(5).maxLength(50).build(),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Password',
                    icon: Icon(Icons.password),
                  ),
                  onSaved: (String? value2) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => {
                      if (formkey.currentState!.validate())
                        {print("เข้าอยู่"), SingupWithEmailandPassword()}
                      else
                        {print("Error")}
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 195, 228, 243)),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
