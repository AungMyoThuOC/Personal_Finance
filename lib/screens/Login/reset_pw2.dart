// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:personal_finance/components/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword2 extends StatefulWidget {
  const ResetPassword2({Key? key}) : super(key: key);

  @override
  State<ResetPassword2> createState() => _ResetPassword2State();
}

class _ResetPassword2State extends State<ResetPassword2> {
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Enter a valid email address"),
  ]);

  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernamecontroller = TextEditingController();
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: DefaultTextStyle(
          style: TextStyle(
            color: Colors.grey[900],
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forget Password",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Enter your email we will send reset password link",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          letterSpacing: 0.3),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: usernamecontroller,
                      autovalidateMode: submitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: emailValidator,
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/passcode');
                        },
                        child: Text(
                          'go back to login',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color(0xFF068FFF),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // elevation: 0,
                          // primary: Colors.blue[700],
                          primary: Colors.black,
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            auth.sendPasswordResetEmail(
                              email: usernamecontroller.text,
                            );
                            showSnackbar(
                              context,
                              "We have sent reset password link in your email",
                              4,
                              Colors.green[300],
                            );
                            // Navigator.pushReplacementNamed(context, '/passcode');
                            final prefs = await SharedPreferences.getInstance();
                            final success = await prefs.remove('passwordLogin');
                            // ignore: use_build_context_synchronously
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                        child: const Text(
                          'Send Request',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
