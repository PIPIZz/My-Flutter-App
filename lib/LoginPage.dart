import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:myflutterapplication/HomePage.dart';
import 'RegisterPage.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ignore: non_constant_identifier_names
  Loginbutton() async {
    try {
      final email = emailController.value.text;
      final password = passwordController.value.text;
      await Auth().SingInWithEmailandPassword(email, password)
      .then((res) async => {
            _formkey.currentState!.reset(),
            Fluttertoast.showToast(
              msg: "Login Success",
              gravity: ToastGravity.CENTER
            ),
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Homepage();
            }))
      });
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
      // print(e.message);
      Fluttertoast.showToast(
        msg: e.code,
        gravity: ToastGravity.CENTER
        );
    } catch (e) {
      print(e);
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/loader-cat.gif',
                  width: double.infinity,
                  height: 350,
                ),
                const Text("Login",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      ValidationBuilder().email().minLength(5).maxLength(50).build(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    border: UnderlineInputBorder(),
                    hintText: 'E-mail',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator:
                      ValidationBuilder().minLength(5).maxLength(50).build(),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      border: UnderlineInputBorder(),
                      hintText: 'Password',
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => {
                      if (_formkey.currentState!.validate())
                        {Loginbutton()}
                      else
                        {print("Error")}
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 195, 228, 243)),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
               
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegisterPage();
                    }));
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
