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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.4,
                    child: Lottie.asset(
                      'assets/animations/lottie2.json',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: screenHeight * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[300],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: Text(
                    'Use Proper Information',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.01,
                    horizontal: screenWidth * 0.06,
                  ),
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(fontSize: screenHeight * 0.025),
                    decoration: InputDecoration(
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 2.5,
                        ),
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
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.01,
                    horizontal: screenWidth * 0.06,
                  ),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(fontSize: screenHeight * 0.025),
                    decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 2.5,
                        ),
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
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.01,
                    horizontal: screenWidth * 0.06,
                  ),
                  child: TextField(
                    obscureText: obscureText,
                    controller: passwordController,
                    style: TextStyle(fontSize: screenHeight * 0.025),
                    decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        borderSide: BorderSide(
                          color: Colors.yellow,
                          width: 2.5,
                        ),
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
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  child: LoadingAnimatedButton(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: screenHeight * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
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
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Alredy have an Account?",
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          color: Colors.white,
                        ),
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
                            fontSize: screenHeight * 0.025,
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
