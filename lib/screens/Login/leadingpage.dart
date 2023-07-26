// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  bool showBiometrics = false;

  void loginCheck() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushNamed(context, '/login');
      } else {
        print('User is signed in!');
        Navigator.pushNamed(context, '/passcode');
        // isBiometricAvailable();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'images/app_logo.png',
                      width: 240,
                      height: 240,
                    ),
                  ),
                ),
                const Text(
                  "Save your money",
                  // translation(context).per_fin,
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF3b3b3b),
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   "Find ways to get more income and saving",
                //   style: TextStyle(
                //     color: Colors.grey[700],
                //     fontSize: 13,
                //     letterSpacing: 0.7,
                //   ),
                // ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // elevation: 0, primary: Colors.blue[700]
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      // primary: Colors.blue[700],
                      primary: const Color(0xFFB0B7C0),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
