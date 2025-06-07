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
                    'assets/animations/lottie1.json',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  'Enter valid Email & Password',
                  style: TextStyle(fontSize: 15, color: Colors.white),
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
                    'Login',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have an Account?",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
