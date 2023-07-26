// ignore_for_file: avoid_print, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_finance/components/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';

class MyLogInPage extends StatefulWidget {
  const MyLogInPage({Key? key}) : super(key: key);

  @override
  State<MyLogInPage> createState() => _MyLogInPageState();
}

class _MyLogInPageState extends State<MyLogInPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool pass = true;
  bool confirmpass = true;
  bool submitted = false;
  bool isloading = false;

  late User currentUser;

  final _formKey = GlobalKey<FormState>();

  Timer mytime = Timer.periodic(
    const Duration(seconds: 3),
    ((timer) async {
      print('time reached');
    }),
  );

  final emialValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'enter a valid email address'),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ]);

  bool eye = true;
  var errorMassage = '';

  @override
  void dispose() {
    mytime.cancel();
    //test
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: DefaultTextStyle(
          style: TextStyle(
            color: Colors.grey[900],
          ),
          child: Form(
            key: _formKey,
            child: SizedBox(
              child: Center(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Colors.grey[800]),
                              ),
                              // Text(
                              //   "Hello again you've been missed!",
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w500,
                              //       fontSize: 12,
                              //       color: Colors.grey[700]),
                              // ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 3,
                                ),
                                child: Text(
                                  "Email Address",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: usernamecontroller,
                                autovalidateMode: submitted
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: emialValidator,
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: const TextStyle(fontSize: 12),
                                  labelStyle: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 3,
                                ),
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: passwordcontroller,
                                obscureText: pass,
                                autovalidateMode: submitted
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: passwordValidator,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  hintStyle: const TextStyle(fontSize: 12),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        pass = !pass;
                                      });
                                    },
                                    // splashRadius: 2,
                                    icon: pass
                                        ? Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.grey[800],
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: Colors.grey[800],
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final String? username =
                                        prefs.getString('UserID');

                                    setState(() {
                                      submitted = true;
                                      print('$username');
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isloading = true;
                                      });
                                      try {
                                        final auth = FirebaseAuth.instance;
                                        UserCredential currentUser = await auth
                                            .signInWithEmailAndPassword(
                                          email: usernamecontroller.text,
                                          password: passwordcontroller.text,
                                        );
                                        print(currentUser.user!);
                                        if (currentUser.user!.uid != null) {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          prefs.setString(
                                            'password',
                                            passwordcontroller.text,
                                          );
                                          prefs.setString(
                                            'displayName',
                                            "${currentUser.user!.displayName}",
                                          );
                                          prefs.setString(
                                            'email',
                                            usernamecontroller.text,
                                          );
                                          prefs.setInt('language', 1);
                                          setState(() {
                                            isloading = false;
                                            usernamecontroller.clear();
                                            passwordcontroller.clear();
                                            mytime.cancel();
                                            currentUser.user!.reload();
                                            Navigator.pushReplacementNamed(
                                                context, '/main');
                                          });
                                        }
                                        // setState(() {
                                        //   checkEmail();
                                        // });
                                      } on FirebaseException catch (e) {
                                        String errorMessage = "";
                                        String code = e.code;

                                        if (code == "invalid-email") {
                                          errorMessage = "Invalid email.";
                                        } else if (code == "user-not-found") {
                                          errorMessage = "User not found.";
                                        } else if (code == "wrong-password") {
                                          errorMessage = "Invalid password.";
                                        } else if (code ==
                                            "too-many-requests") {
                                          errorMessage =
                                              "Too many request try again later";
                                        } else if (code ==
                                            "network-request-failed") {
                                          errorMessage =
                                              "Your are currently offline.";
                                        } else {
                                          errorMessage =
                                              "Something went wrong please try again.";
                                        }

                                        showSnackbar(context, errorMessage, 1,
                                            Colors.red[300]);
                                        setState(() {
                                          isloading = false;
                                        });
                                      } catch (e) {
                                        setState(() {
                                          isloading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(e.toString()),
                                            backgroundColor: Colors.red[300],
                                            duration: const Duration(
                                              seconds: 1,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      // elevation: 0,
                                      // primary: Colors.blue[700],
                                      primary: Colors.black),
                                  child: isloading
                                      ? const SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Login',
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                  fontSize: 12,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/register',
                                  );
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 30),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue[600],
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
