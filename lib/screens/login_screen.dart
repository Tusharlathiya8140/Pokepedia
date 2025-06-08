import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepedia/screens/registration_screen.dart';

import '../widgets/button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    emailController.addListener(() {
      listener:
      (context);
    });
    passwordController.addListener(() {
      listener:
      (context);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.removeListener(() {
      listener:
      (context);
    });

    passwordController.removeListener(() {
      listener:
      (context);
    });
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
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
                      'assets/animations/lottie1.json',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: screenHeight * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[300],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: Text(
                    'Enter valid Email & Password',
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
                      'Login',
                      style: TextStyle(
                        fontSize: screenHeight * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      loginUser();
                      final form = formKey.currentState!;
                      String email = emailController.text;
                      String password = passwordController.text;
                      if (form.validate()) {
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
                        "Don't Have an Account?",
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
                              builder: (context) => RegistrationScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up !',
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

  void loginUser() {
    if (passwordController.text == '') {
      Fluttertoast.showToast(
        msg: "Password can't be blank",
        backgroundColor: Colors.red,
      );
    } else {
      String email = emailController.text;
      String password = passwordController.text;
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          })
          .catchError((e) {
            Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
          });
    }
  }
}
