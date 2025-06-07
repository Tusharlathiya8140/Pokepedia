import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepedia/screens/home_screen.dart';

import '../widgets/button.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 350,
                  width: 350,
                  child: Lottie.asset(
                    'assets/animations/lottie2.json',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[300],
                  ),
                ),
              ),
              Text(
                'Use Proper Information',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 2.5),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    suffixIcon: nameController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            onPressed: () {
                              nameController.clear();
                            },
                            icon: Icon(Icons.close, color: Colors.black),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: TextField(
                  controller: emailController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 2.5),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.black),
                    suffixIcon: emailController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            onPressed: () {
                              emailController.clear();
                            },
                            icon: Icon(Icons.close, color: Colors.black),
                          ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: TextField(
                  obscureText: obscureText,
                  controller: passwordController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.yellow, width: 2.5),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    suffixIcon: passwordController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = false;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: LoadingAnimatedButton(
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    print('button pressed');
                    registerUser();
                    final form = formKey.currentState!;
                    String name = nameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;
                    if (form.validate()) {
                      final name = nameController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                    } else {}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Alredy have an Account?",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In !',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.yellow[300],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() {
    if (nameController.text == '') {
      Fluttertoast.showToast(
        msg: "Name can't be blank",
        backgroundColor: Colors.red,
      );
    } else if (emailController.text == '') {
      Fluttertoast.showToast(
        msg: "Email can't be blank",
        backgroundColor: Colors.red,
      );
    } else if (passwordController.text == '') {
      Fluttertoast.showToast(
        msg: "Password can't be blank",
        backgroundColor: Colors.red,
      );
    } else {
      String email = emailController.text;
      String password = passwordController.text;
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            if (value != null) {
              var user = value.user;
              var uid = user!.uid;
              addUserData(uid);
            }
          })
          .catchError((e) {
            Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
          });
    }
  }

  void addUserData(String uid) {
    Map<String, dynamic> usersData = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'uid': uid,
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(usersData)
        .then((value) {
          Fluttertoast.showToast(
            msg: 'Registration Successful',
            backgroundColor: Colors.green,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        })
        .catchError((e) {
          Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
          print(e);
        });
  }
}
